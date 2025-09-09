import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/export_data.dart';
import '../models/trip.dart';
import '../models/todo_item.dart';
import '../models/booking.dart';
import '../models/expense.dart';
import '../models/document.dart';
import '../repositories/trip_repository.dart';
import '../repositories/todo_repository.dart';
import '../repositories/booking_repository.dart';
import '../repositories/expense_repository.dart';
import '../repositories/document_repository.dart';

class ImportService {
  static const String _fileExtension = '.tripe';

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
      print('Import started: Reading file...');
      
      // Read the file
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('Import file not found');
      }
      
      if (!filePath.endsWith(_fileExtension)) {
        throw Exception('Invalid file format. Expected .tripe file');
      }
      
      print('Import: Reading compressed data...');
      final compressedBytes = await file.readAsBytes();
      
      // Decompress the data
      print('Import: Decompressing data...');
      final tarBytes = GZipDecoder().decodeBytes(compressedBytes);
      final archive = TarDecoder().decodeBytes(tarBytes);
      
      // Extract files from archive
      Map<String, dynamic>? metadata;
      Map<String, dynamic>? encryptionInfo;
      String? dataContent;
      
      for (final file in archive) {
        final fileName = file.name;
        final content = utf8.decode(file.content);
        
        if (fileName == 'metadata.json') {
          metadata = jsonDecode(content);
        } else if (fileName == 'encryption.json') {
          encryptionInfo = jsonDecode(content);
        } else if (fileName == 'data.json') {
          dataContent = content;
        }
      }
      
      if (metadata == null) {
        throw Exception('Invalid backup file: Missing metadata');
      }
      
      if (dataContent == null) {
        throw Exception('Invalid backup file: Missing data');
      }
      
      print('Import: Validating backup file...');
      print('Import: Backup created: ${metadata['created']}');
      print('Import: App: ${metadata['app']}');
      print('Import: Version: ${metadata['version']}');
      print('Import: Encrypted: ${metadata['encrypted']}');
      
      // Verify this is a Voythrix or legacy TripEase backup
      final appTag = metadata['app']?.toString() ?? '';
      final isVoythrix = appTag == 'Voythrix';
      final isTripEase = appTag == 'TripEase';
      if (!isVoythrix && !isTripEase) {
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
        
        print('Import: Decrypting data...');
        try {
          final iv = IV.fromBase64(encryptionInfo['iv']);
          // Use salt compatible with the backup source (Voythrix or TripEase)
          final salt = isVoythrix ? 'voythrix_salt_2024' : 'tripease_salt_2024';
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
        print('Import: Checksum verified successfully');
      }
      
      // Parse the JSON data
      print('Import: Parsing backup data...');
      final exportData = ExportData.fromJsonString(jsonData);
      
      print('Import: Found data:');
      print('  Trips: ${exportData.trips.length}');
      print('  Todos: ${exportData.todos.length}');
      print('  Bookings: ${exportData.bookings.length}');
      print('  Expenses: ${exportData.expenses.length}');
      print('  Documents: ${exportData.documents.length}');
      print('  Settings: ${exportData.settings.length} items');
      
      // Import all data
      await _importDataToDatabase(
        exportData,
        tripRepository,
        todoRepository,
        bookingRepository,
        expenseRepository,
        documentRepository,
      );
      
      // Import app settings
      await _importAppSettings(exportData.settings);
      
      print('Import: Import completed successfully');
      return exportData;
      
    } catch (e, stackTrace) {
      print('Import error: $e');
      print('Stack trace: $stackTrace');
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
    print('Import: Starting database import...');
    
    // Import trips first
    print('Import: Importing ${exportData.trips.length} trips...');
    for (final trip in exportData.trips) {
      try {
        await tripRepository.createTrip(trip);
      } catch (e) {
        print('Import: Warning - Failed to import trip ${trip.id}: $e');
        // Continue with other trips
      }
    }
    
    // Import todos
    print('Import: Importing ${exportData.todos.length} todos...');
    for (final todo in exportData.todos) {
      try {
        await todoRepository.createTodo(todo);
      } catch (e) {
        print('Import: Warning - Failed to import todo ${todo.id}: $e');
        // Continue with other todos
      }
    }
    
    // Import bookings
    print('Import: Importing ${exportData.bookings.length} bookings...');
    for (final booking in exportData.bookings) {
      try {
        await bookingRepository.createBooking(booking);
      } catch (e) {
        print('Import: Warning - Failed to import booking ${booking.id}: $e');
        // Continue with other bookings
      }
    }
    
    // Import expenses
    print('Import: Importing ${exportData.expenses.length} expenses...');
    for (final expense in exportData.expenses) {
      try {
        await expenseRepository.createExpense(expense);
      } catch (e) {
        print('Import: Warning - Failed to import expense ${expense.id}: $e');
        // Continue with other expenses
      }
    }
    
    // Import documents (note: this will only import metadata, not actual files)
    print('Import: Importing ${exportData.documents.length} document records...');
    for (final document in exportData.documents) {
      try {
        await documentRepository.createDocument(document);
      } catch (e) {
        print('Import: Warning - Failed to import document ${document.id}: $e');
        // Continue with other documents
      }
    }
    
    print('Import: Database import completed');
  }
  
  static Future<void> _importAppSettings(Map<String, dynamic> settings) async {
    print('Import: Importing app settings...');
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
        print('Import: Warning - Failed to import setting ${entry.key}: $e');
        // Continue with other settings
      }
    }
    
    print('Import: App settings imported');
  }
  
  static String _generateChecksum(String data) {
    return sha256.convert(utf8.encode(data)).toString();
  }
  
  static String _deriveKeyFromPassword(String password, {required String salt}) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return base64.encode(digest.bytes);
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
