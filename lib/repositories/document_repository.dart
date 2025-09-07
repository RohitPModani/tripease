import '../database/database.dart';
import '../models/document.dart';
import 'package:drift/drift.dart';

class DocumentRepository {
  final AppDatabase _database;

  DocumentRepository(this._database);

  // Create a new document
  Future<void> createDocument(Document document) async {
    await _database.into(_database.documentsTable).insert(document.toEntity());
  }

  // Get all documents for a trip
  Future<List<Document>> getDocumentsByTripId(String tripId) async {
    final entities = await (_database.select(_database.documentsTable)
          ..where((d) => d.tripId.equals(tripId))
          ..orderBy([(d) => OrderingTerm(expression: d.createdAt, mode: OrderingMode.desc)]))
        .get();
    return entities.map((entity) => Document.fromEntity(entity)).toList();
  }

  // Get all personal documents
  Future<List<Document>> getPersonalDocuments() async {
    final entities = await (_database.select(_database.documentsTable)
          ..where((d) => d.isPersonal.equals(true))
          ..orderBy([(d) => OrderingTerm(expression: d.createdAt, mode: OrderingMode.desc)]))
        .get();
    return entities.map((entity) => Document.fromEntity(entity)).toList();
  }

  // Get document by ID
  Future<Document?> getDocumentById(String documentId) async {
    final entity = await (_database.select(_database.documentsTable)
          ..where((d) => d.id.equals(documentId)))
        .getSingleOrNull();
    return entity != null ? Document.fromEntity(entity) : null;
  }

  // Update document
  Future<void> updateDocument(Document document) async {
    await (_database.update(_database.documentsTable)
          ..where((d) => d.id.equals(document.id)))
        .write(document.toEntity());
  }

  // Delete document
  Future<void> deleteDocument(String documentId) async {
    await (_database.delete(_database.documentsTable)
          ..where((d) => d.id.equals(documentId)))
        .go();
  }

  // Get documents by type
  Future<List<Document>> getDocumentsByType(DocumentType type, {String? tripId}) async {
    var query = _database.select(_database.documentsTable)
      ..where((d) => d.type.equals(type.index));
    
    if (tripId != null) {
      query = query..where((d) => d.tripId.equals(tripId));
    }
    
    query = query..orderBy([(d) => OrderingTerm(expression: d.createdAt, mode: OrderingMode.desc)]);
    
    final entities = await query.get();
    return entities.map((entity) => Document.fromEntity(entity)).toList();
  }

  // Get documents by type for a trip
  Future<List<Document>> getTripDocumentsByType(String tripId, DocumentType type) async {
    final entities = await (_database.select(_database.documentsTable)
          ..where((d) => 
              d.tripId.equals(tripId) & 
              d.type.equals(type.index))
          ..orderBy([(d) => OrderingTerm(expression: d.createdAt, mode: OrderingMode.desc)]))
        .get();
    return entities.map((entity) => Document.fromEntity(entity)).toList();
  }

  // Get personal documents by type
  Future<List<Document>> getPersonalDocumentsByType(DocumentType type) async {
    final entities = await (_database.select(_database.documentsTable)
          ..where((d) => 
              d.isPersonal.equals(true) & 
              d.type.equals(type.index))
          ..orderBy([(d) => OrderingTerm(expression: d.createdAt, mode: OrderingMode.desc)]))
        .get();
    return entities.map((entity) => Document.fromEntity(entity)).toList();
  }

  // Search documents by title
  Future<List<Document>> searchDocuments(String searchQuery, {String? tripId}) async {
    var query = _database.select(_database.documentsTable)
      ..where((d) => d.title.contains(searchQuery));
    
    if (tripId != null) {
      query = query..where((d) => d.tripId.equals(tripId));
    }
    
    query = query..orderBy([(d) => OrderingTerm(expression: d.createdAt, mode: OrderingMode.desc)]);
    
    final entities = await query.get();
    return entities.map((entity) => Document.fromEntity(entity)).toList();
  }

  // Get total file size for a trip
  Future<int> getTotalFileSize(String tripId) async {
    final result = await (_database.selectOnly(_database.documentsTable)
          ..addColumns([_database.documentsTable.fileSize.sum()])
          ..where(_database.documentsTable.tripId.equals(tripId)))
        .getSingleOrNull();
    return result?.read(_database.documentsTable.fileSize.sum()) ?? 0;
  }

  // Get total personal documents file size
  Future<int> getTotalPersonalFileSize() async {
    final result = await (_database.selectOnly(_database.documentsTable)
          ..addColumns([_database.documentsTable.fileSize.sum()])
          ..where(_database.documentsTable.isPersonal.equals(true)))
        .getSingleOrNull();
    return result?.read(_database.documentsTable.fileSize.sum()) ?? 0;
  }

  // Get document statistics for a trip
  Future<Map<String, dynamic>> getDocumentStats(String tripId) async {
    final documents = await getDocumentsByTripId(tripId);
    final totalSize = documents.fold<int>(0, (sum, doc) => sum + doc.fileSize);
    
    // Count by type
    final typeStats = <String, int>{};
    for (final type in DocumentType.values) {
      typeStats[type.name] = documents.where((d) => d.type == type).length;
    }

    return {
      'total': documents.length,
      'totalSize': totalSize,
      'byType': typeStats,
      'averageSize': documents.isNotEmpty ? totalSize / documents.length : 0,
    };
  }

  // Get personal document statistics
  Future<Map<String, dynamic>> getPersonalDocumentStats() async {
    final documents = await getPersonalDocuments();
    final totalSize = documents.fold<int>(0, (sum, doc) => sum + doc.fileSize);
    
    // Count by type
    final typeStats = <String, int>{};
    for (final type in DocumentType.values) {
      typeStats[type.name] = documents.where((d) => d.type == type).length;
    }

    return {
      'total': documents.length,
      'totalSize': totalSize,
      'byType': typeStats,
      'averageSize': documents.isNotEmpty ? totalSize / documents.length : 0,
    };
  }

  // Get recent documents (last 30 days)
  Future<List<Document>> getRecentDocuments({String? tripId, int days = 30}) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    
    var query = _database.select(_database.documentsTable)
      ..where((d) => d.createdAt.isBiggerThanValue(cutoffDate));
    
    if (tripId != null) {
      query = query..where((d) => d.tripId.equals(tripId));
    }
    
    query = query..orderBy([(d) => OrderingTerm(expression: d.createdAt, mode: OrderingMode.desc)]);
    
    final entities = await query.get();
    return entities.map((entity) => Document.fromEntity(entity)).toList();
  }

  // Move document between trips
  Future<void> moveDocumentToTrip(String documentId, String? newTripId) async {
    await (_database.update(_database.documentsTable)
          ..where((d) => d.id.equals(documentId)))
        .write(DocumentsTableCompanion(
          tripId: Value(newTripId),
          isPersonal: Value(newTripId == null),
          updatedAt: Value(DateTime.now()),
        ));
  }
}