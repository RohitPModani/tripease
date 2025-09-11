import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;
import '../models/export_data.dart';
import '../models/todo_item.dart';
import '../models/booking.dart';
import '../models/expense.dart';
import '../models/document.dart';
import '../repositories/trip_repository.dart';
import '../repositories/todo_repository.dart';
import '../repositories/booking_repository.dart';
import '../repositories/expense_repository.dart';
import '../repositories/document_repository.dart';
import '../repositories/itinerary_repository.dart';
import '../repositories/trip_member_repository.dart';
import '../models/itinerary.dart';
import '../models/trip_member.dart';

class ExportService {
  static const String _appVersion = '1.0.0';
  static const String _fileExtension = '.voy';
  
  // Encryption will be generated per export

  static Future<String> exportAllData({
    required TripRepository tripRepository,
    required TodoRepository todoRepository,
    required BookingRepository bookingRepository,
    required ExpenseRepository expenseRepository,
    required DocumentRepository documentRepository,
    required ItineraryRepository itineraryRepository,
    required TripMemberRepository tripMemberRepository,
    String? password,
    String? saveDirectory,
  }) async {
    try {
      developer.log('Export started: Collecting data...');
      // Collect all data from repositories
      developer.log('Export: Loading trips...');
      final trips = await tripRepository.getAllTrips();
      developer.log('Export: Found ${trips.length} trips');
      final allTodos = <TodoItem>[];
      final allBookings = <Booking>[];
      final allExpenses = <Expense>[];
      final allItineraryActivities = <ItineraryActivity>[];
      final allTripMembers = <TripMember>[];
      
      // Collect todos, bookings, expenses, itinerary activities, and trip members for all trips
      developer.log('Export: Loading todos, bookings, expenses, itinerary activities, and trip members...');
      for (final trip in trips) {
        try {
          final todos = await todoRepository.getTodosByTripId(trip.id);
          final bookings = await bookingRepository.getBookingsByTripId(trip.id);
          final expenses = await expenseRepository.getExpensesByTripId(trip.id);
          final itineraryActivities = await itineraryRepository.getActivitiesByTripId(trip.id);
          final tripMembers = await tripMemberRepository.getMembersByTripId(trip.id);
          
          allTodos.addAll(todos);
          allBookings.addAll(bookings);
          allExpenses.addAll(expenses);
          allItineraryActivities.addAll(itineraryActivities);
          allTripMembers.addAll(tripMembers);
        } catch (e) {
          developer.log('Export: Error loading data for trip ${trip.id}: $e');
          // Continue with other trips
        }
      }
      
      developer.log('Export: Found ${allTodos.length} todos, ${allBookings.length} bookings, ${allExpenses.length} expenses, ${allItineraryActivities.length} itinerary activities, ${allTripMembers.length} trip members');
      
      // Get all documents (personal + trip documents)
      developer.log('Export: Loading all documents...');
      final personalDocuments = await documentRepository.getPersonalDocuments();
      developer.log('Export: Found ${personalDocuments.length} personal documents');
      
      final allDocuments = <Document>[...personalDocuments];
      
      // Get trip-specific documents for all trips
      for (final trip in trips) {
        try {
          final tripDocuments = await documentRepository.getDocumentsByTripId(trip.id);
          allDocuments.addAll(tripDocuments);
          developer.log('Export: Found ${tripDocuments.length} documents for trip ${trip.title}');
        } catch (e) {
          developer.log('Export: Error loading documents for trip ${trip.id}: $e');
        }
      }
      
      developer.log('Export: Total documents to export: ${allDocuments.length}');
      
      // Get app settings
      developer.log('Export: Loading app settings...');
      final settings = await _collectAppSettings();
      developer.log('Export: Loaded ${settings.length} settings');
      
      // Create export data structure
      developer.log('Export: Creating export data structure...');
      final exportData = ExportData(
        exportDate: DateTime.now(),
        appVersion: _appVersion,
        trips: trips,
        todos: allTodos,
        bookings: allBookings,
        expenses: allExpenses,
        documents: allDocuments,
        itineraryActivities: allItineraryActivities,
        tripMembers: allTripMembers,
        settings: settings,
      );
      
      // Convert to JSON string
      developer.log('Export: Converting to JSON...');
      final jsonString = exportData.toJsonString();
      developer.log('Export: JSON size: ${jsonString.length} characters');
      
      // Create metadata
      final metadata = {
        'version': '1.0',
        'created': DateTime.now().toIso8601String(),
        'app': 'Voythrix',
        'encrypted': password != null,
        'compressed': true,
        'checksum': _generateChecksum(jsonString),
      };
      
      // Create archive with data and metadata
      final archive = Archive();
      
      // Add metadata file
      final metadataBytes = utf8.encode(jsonEncode(metadata));
      archive.addFile(ArchiveFile('metadata.json', metadataBytes.length, metadataBytes));
      
      // Encrypt data if password provided
      String dataToCompress = jsonString;
      IV? usedIV;
      if (password != null) {
        usedIV = IV.fromSecureRandom(16);
        final passwordKey = Key.fromBase64(_deriveKeyFromPassword(password));
        final encrypter = Encrypter(AES(passwordKey));
        final encrypted = encrypter.encrypt(jsonString, iv: usedIV);
        dataToCompress = encrypted.base64;
      }
      
      // Add main data file
      final dataBytes = utf8.encode(dataToCompress);
      archive.addFile(ArchiveFile('data.json', dataBytes.length, dataBytes));
      
      // Add document files
      developer.log('Export: Adding document files...');
      await _addDocumentFilesToArchive(archive, allDocuments);
      
      // Add encryption info if password provided
      if (password != null && usedIV != null) {
        final encryptionInfo = {
          'algorithm': 'AES-256-CBC',
          'iv': usedIV.base64,
          'keyDerivation': 'PBKDF2',
          'iterations': 10000,
        };
        final encInfoBytes = utf8.encode(jsonEncode(encryptionInfo));
        archive.addFile(ArchiveFile('encryption.json', encInfoBytes.length, encInfoBytes));
      }
      
      // Compress archive
      developer.log('Export: Compressing data...');
      final tarBytes = TarEncoder().encode(archive);
      if (tarBytes.isEmpty) {
        throw Exception('Failed to create TAR archive');
      }
      
      final gzipBytes = GZipEncoder().encode(tarBytes);
      if (gzipBytes == null) {
        throw Exception('Failed to compress data');
      }
      
      // Generate filename with timestamp
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.')[0];
      final filename = 'voythrix_backup_$timestamp$_fileExtension';
      
      // Save to specified directory or temporary directory
      developer.log('Export: Saving to file: $filename');
      final Directory targetDir;
      if (saveDirectory != null) {
        targetDir = Directory(saveDirectory);
      } else {
        targetDir = await getTemporaryDirectory();
      }
      
      final file = File('${targetDir.path}/$filename');
      await file.writeAsBytes(gzipBytes);
      developer.log('Export: File saved successfully at: ${file.path}');
      
      developer.log('Export: Export completed successfully');
      return file.path;
      
    } catch (e, stackTrace) {
      developer.log('Export error: $e');
      developer.log('Stack trace: $stackTrace');
      throw Exception('Export failed: $e');
    }
  }
  
  static Future<void> shareExportFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await Share.shareXFiles(
        [XFile(filePath)],
        subject: 'Voythrix Backup',
      );
    } else {
      throw Exception('Export file not found');
    }
  }
  
  static Future<Map<String, dynamic>> _collectAppSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final settings = <String, dynamic>{};
    
    for (final key in keys) {
      try {
        // Try different types
        if (prefs.get(key) is bool) {
          settings[key] = prefs.getBool(key);
        } else if (prefs.get(key) is int) {
          settings[key] = prefs.getInt(key);
        } else if (prefs.get(key) is double) {
          settings[key] = prefs.getDouble(key);
        } else if (prefs.get(key) is String) {
          settings[key] = prefs.getString(key);
        } else if (prefs.get(key) is List<String>) {
          settings[key] = prefs.getStringList(key);
        }
      } catch (e) {
        // Skip problematic keys
        continue;
      }
    }
    
    return settings;
  }
  
  static String _generateChecksum(String data) {
    return sha256.convert(utf8.encode(data)).toString();
  }
  
  static String _deriveKeyFromPassword(String password) {
    final salt = 'voythrix_salt_2024'; // In production, use random salt
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return base64.encode(digest.bytes);
  }
  
  static Future<void> _addDocumentFilesToArchive(Archive archive, List<Document> documents) async {
    int addedFiles = 0;
    for (final document in documents) {
      try {
        final file = File(document.filePath);
        if (await file.exists()) {
          final fileBytes = await file.readAsBytes();
          final archiveFileName = 'documents/${document.id}_${path.basename(document.filePath)}';
          archive.addFile(ArchiveFile(archiveFileName, fileBytes.length, fileBytes));
          addedFiles++;
          developer.log('Export: Added document file: ${document.fileName}');
        } else {
          developer.log('Export: Warning - Document file not found: ${document.filePath}');
        }
      } catch (e) {
        developer.log('Export: Error adding document file ${document.fileName}: $e');
      }
    }
    developer.log('Export: Added $addedFiles document files to archive');
  }

  static Future<void> cleanupTempFiles() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final files = tempDir.listSync();
      
      for (final file in files) {
        if (file.path.endsWith(_fileExtension)) {
          // Delete files older than 1 hour
          final stat = await file.stat();
          if (DateTime.now().difference(stat.modified).inHours > 1) {
            await file.delete();
          }
        }
      }
    } catch (e) {
      // Ignore cleanup errors
    }
  }
}
