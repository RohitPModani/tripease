import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../models/export_data.dart';
import '../models/document.dart';
import '../repositories/trip_repository.dart';
import '../repositories/todo_repository.dart';
import '../repositories/booking_repository.dart';
import '../repositories/expense_repository.dart';
import '../repositories/document_repository.dart';

class ImportService {
  static const String _fileExtension = '.voy';

  static Future<ExportData> importAllData({
    required String filePath,
    required TripRepository tripRepository,
    required TodoRepository todoRepository,
    required BookingRepository bookingRepository,
    required ExpenseRepository expenseRepository,
    required DocumentRepository documentRepository,
    String? password,
  }) async {
    try {
      developer.log('Import started: Reading file...');
      
      // Read the file
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('Import file not found');
      }
      
      if (!filePath.endsWith(_fileExtension)) {
        throw Exception('Invalid file format. Expected .voy file');
      }
      
      developer.log('Import: Reading compressed data...');
      final compressedBytes = await file.readAsBytes();
      
      // Decompress the data
      developer.log('Import: Decompressing data...');
      final tarBytes = GZipDecoder().decodeBytes(compressedBytes);
      final archive = TarDecoder().decodeBytes(tarBytes);
      
      // Extract files from archive
      Map<String, dynamic>? metadata;
      Map<String, dynamic>? encryptionInfo;
      String? dataContent;
      
      for (final file in archive) {
        final fileName = file.name;
        
        // Only decode text files as UTF-8, skip binary files (documents)
        if (fileName == 'metadata.json') {
          final content = utf8.decode(file.content);
          metadata = jsonDecode(content);
        } else if (fileName == 'encryption.json') {
          final content = utf8.decode(file.content);
          encryptionInfo = jsonDecode(content);
        } else if (fileName == 'data.json') {
          final content = utf8.decode(file.content);
          dataContent = content;
        }
        // Skip document files - they will be handled separately during extraction
      }
      
      if (metadata == null) {
        throw Exception('Invalid backup file: Missing metadata');
      }
      
      if (dataContent == null) {
        throw Exception('Invalid backup file: Missing data');
      }
      
      developer.log('Import: Validating backup file...');
      developer.log('Import: Backup created: ${metadata['created']}');
      developer.log('Import: App: ${metadata['app']}');
      developer.log('Import: Version: ${metadata['version']}');
      developer.log('Import: Encrypted: ${metadata['encrypted']}');
      
      // Verify this is a Voythrix backup
      final appTag = metadata['app']?.toString() ?? '';
      final isVoythrix = appTag == 'Voythrix';
      if (!isVoythrix) {
        throw Exception('This backup file is not from Voythrix');
      }
      
      // Decrypt data if needed
      String jsonData = dataContent;
      if (metadata['encrypted'] == true) {
        if (password == null || password.isEmpty) {
          throw Exception('This backup is password protected. Please provide the password.');
        }
        
        if (encryptionInfo == null) {
          throw Exception('Invalid backup file: Missing encryption information');
        }
        
        developer.log('Import: Decrypting data...');
        try {
          final iv = IV.fromBase64(encryptionInfo['iv']);
          // Use Voythrix salt for decryption
          final salt = 'voythrix_salt_2024';
          final passwordKey = Key.fromBase64(_deriveKeyFromPassword(password, salt: salt));
          final encrypter = Encrypter(AES(passwordKey));
          final encrypted = Encrypted.fromBase64(dataContent);
          jsonData = encrypter.decrypt(encrypted, iv: iv);
        } catch (e) {
          throw Exception('Failed to decrypt backup. Please check your password.');
        }
      }
      
      // Verify checksum if available
      if (metadata['checksum'] != null) {
        final expectedChecksum = metadata['checksum'];
        final actualChecksum = _generateChecksum(jsonData);
        if (expectedChecksum != actualChecksum) {
          throw Exception('Backup file is corrupted. Checksum verification failed.');
        }
        developer.log('Import: Checksum verified successfully');
      }
      
      // Parse the JSON data
      developer.log('Import: Parsing backup data...');
      final exportData = ExportData.fromJsonString(jsonData);
      
      developer.log('Import: Found data:');
      developer.log('  Trips: ${exportData.trips.length}');
      developer.log('  Todos: ${exportData.todos.length}');
      developer.log('  Bookings: ${exportData.bookings.length}');
      developer.log('  Expenses: ${exportData.expenses.length}');
      developer.log('  Documents: ${exportData.documents.length}');
      developer.log('  Settings: ${exportData.settings.length} items');
      
      // Extract document files first
      developer.log('Import: Extracting document files...');
      final updatedDocuments = await _extractDocumentFiles(archive, exportData.documents);
      
      // Update export data with new file paths
      final updatedExportData = ExportData(
        exportDate: exportData.exportDate,
        appVersion: exportData.appVersion,
        trips: exportData.trips,
        todos: exportData.todos,
        bookings: exportData.bookings,
        expenses: exportData.expenses,
        documents: updatedDocuments,
        settings: exportData.settings,
      );
      
      // Import all data
      await _importDataToDatabase(
        updatedExportData,
        tripRepository,
        todoRepository,
        bookingRepository,
        expenseRepository,
        documentRepository,
      );
      
      // Import app settings
      await _importAppSettings(exportData.settings);
      
      developer.log('Import: Import completed successfully');
      return updatedExportData;
      
    } catch (e, stackTrace) {
      developer.log('Import error: $e');
      developer.log('Stack trace: $stackTrace');
      throw Exception('Import failed: $e');
    }
  }
  
  static Future<void> _importDataToDatabase(
    ExportData exportData,
    TripRepository tripRepository,
    TodoRepository todoRepository,
    BookingRepository bookingRepository,
    ExpenseRepository expenseRepository,
    DocumentRepository documentRepository,
  ) async {
    developer.log('Import: Starting database import...');
    
    // Import trips first with duplicate ID handling
    developer.log('Import: Importing ${exportData.trips.length} trips...');
    for (final trip in exportData.trips) {
      try {
        final existingTrip = await tripRepository.getTripById(trip.id);
        if (existingTrip != null) {
          await tripRepository.updateTrip(trip);
          developer.log('Import: Updated existing trip ${trip.id}');
        } else {
          await tripRepository.createTrip(trip);
          developer.log('Import: Created new trip ${trip.id}');
        }
      } catch (e) {
        developer.log('Import: Warning - Failed to import trip ${trip.id}: $e');
        // Continue with other trips
      }
    }
    
    // Import todos with duplicate ID handling
    developer.log('Import: Importing ${exportData.todos.length} todos...');
    for (final todo in exportData.todos) {
      try {
        final existingTodo = await todoRepository.getTodoById(todo.id);
        if (existingTodo != null) {
          await todoRepository.updateTodo(todo);
          developer.log('Import: Updated existing todo ${todo.id}');
        } else {
          await todoRepository.createTodo(todo);
          developer.log('Import: Created new todo ${todo.id}');
        }
      } catch (e) {
        developer.log('Import: Warning - Failed to import todo ${todo.id}: $e');
        // Continue with other todos
      }
    }
    
    // Import bookings with duplicate ID handling
    developer.log('Import: Importing ${exportData.bookings.length} bookings...');
    for (final booking in exportData.bookings) {
      try {
        final existingBooking = await bookingRepository.getBookingById(booking.id);
        if (existingBooking != null) {
          await bookingRepository.updateBooking(booking);
          developer.log('Import: Updated existing booking ${booking.id}');
        } else {
          await bookingRepository.createBooking(booking);
          developer.log('Import: Created new booking ${booking.id}');
        }
      } catch (e) {
        developer.log('Import: Warning - Failed to import booking ${booking.id}: $e');
        // Continue with other bookings
      }
    }
    
    // Import expenses with duplicate ID handling
    developer.log('Import: Importing ${exportData.expenses.length} expenses...');
    for (final expense in exportData.expenses) {
      try {
        final existingExpense = await expenseRepository.getExpenseById(expense.id);
        if (existingExpense != null) {
          await expenseRepository.updateExpense(expense);
          developer.log('Import: Updated existing expense ${expense.id}');
        } else {
          await expenseRepository.createExpense(expense);
          developer.log('Import: Created new expense ${expense.id}');
        }
      } catch (e) {
        developer.log('Import: Warning - Failed to import expense ${expense.id}: $e');
        // Continue with other expenses
      }
    }
    
    // Import documents with duplicate ID handling
    developer.log('Import: Importing ${exportData.documents.length} document records...');
    for (final document in exportData.documents) {
      try {
        // Check if document with this ID already exists
        final existingDocument = await documentRepository.getDocumentById(document.id);
        if (existingDocument != null) {
          // Document exists, update it instead of creating
          await documentRepository.updateDocument(document);
          developer.log('Import: Updated existing document ${document.id}');
        } else {
          // Document doesn't exist, create new one
          await documentRepository.createDocument(document);
          developer.log('Import: Created new document ${document.id}');
        }
      } catch (e) {
        developer.log('Import: Warning - Failed to import document ${document.id}: $e');
        // Continue with other documents
      }
    }
    
    developer.log('Import: Database import completed');
  }
  
  static Future<void> _importAppSettings(Map<String, dynamic> settings) async {
    developer.log('Import: Importing app settings...');
    final prefs = await SharedPreferences.getInstance();
    
    for (final entry in settings.entries) {
      try {
        final key = entry.key;
        final value = entry.value;
        
        if (value is bool) {
          await prefs.setBool(key, value);
        } else if (value is int) {
          await prefs.setInt(key, value);
        } else if (value is double) {
          await prefs.setDouble(key, value);
        } else if (value is String) {
          await prefs.setString(key, value);
        } else if (value is List<String>) {
          await prefs.setStringList(key, value);
        }
      } catch (e) {
        developer.log('Import: Warning - Failed to import setting ${entry.key}: $e');
        // Continue with other settings
      }
    }
    
    developer.log('Import: App settings imported');
  }
  
  static String _generateChecksum(String data) {
    return sha256.convert(utf8.encode(data)).toString();
  }
  
  static String _deriveKeyFromPassword(String password, {required String salt}) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return base64.encode(digest.bytes);
  }
  
  static Future<List<Document>> _extractDocumentFiles(Archive archive, List<Document> documents) async {
    final appDir = await getApplicationDocumentsDirectory();
    final documentsDir = Directory(path.join(appDir.path, 'documents'));
    
    // Create documents directory if it doesn't exist
    if (!await documentsDir.exists()) {
      await documentsDir.create(recursive: true);
    }
    
    final updatedDocuments = <Document>[];
    int extractedFiles = 0;
    
    for (final document in documents) {
      try {
        // Look for the document file in the archive
        final archiveFileName = 'documents/${document.id}_${path.basename(document.filePath)}';
        final archiveFile = archive.files.firstWhere(
          (file) => file.name == archiveFileName,
          orElse: () => throw Exception('Document file not found in archive'),
        );
        
        // Create new file path in the app documents directory
        final newFileName = '${document.id}_${document.fileName}';
        final newFilePath = path.join(documentsDir.path, newFileName);
        
        // Extract and write the file
        final file = File(newFilePath);
        await file.writeAsBytes(archiveFile.content);
        
        // Create updated document with new file path
        final updatedDocument = document.copyWith(filePath: newFilePath);
        updatedDocuments.add(updatedDocument);
        
        extractedFiles++;
        developer.log('Import: Extracted document file: ${document.fileName}');
      } catch (e) {
        developer.log('Import: Warning - Could not extract document file ${document.fileName}: $e');
        // Add document with original path (might not exist, but metadata is preserved)
        updatedDocuments.add(document);
      }
    }
    
    developer.log('Import: Extracted $extractedFiles document files');
    return updatedDocuments;
  }
  
  static Future<Map<String, dynamic>> getBackupInfo(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('File not found');
      }
      
      if (!filePath.endsWith(_fileExtension)) {
        throw Exception('Invalid file format');
      }
      
      final compressedBytes = await file.readAsBytes();
      final tarBytes = GZipDecoder().decodeBytes(compressedBytes);
      final archive = TarDecoder().decodeBytes(tarBytes);
      
      // Extract metadata
      for (final file in archive) {
        if (file.name == 'metadata.json') {
          final content = utf8.decode(file.content);
          final metadata = jsonDecode(content) as Map<String, dynamic>;
          
          // Add file size information
          metadata['fileSize'] = compressedBytes.length;
          metadata['fileName'] = filePath.split('/').last;
          
          return metadata;
        }
      }
      
      throw Exception('Invalid backup file: No metadata found');
    } catch (e) {
      throw Exception('Failed to read backup info: $e');
    }
  }
}
