import '../database/database.dart';

enum DocumentType { passport, visa, ticket, hotel, insurance, other }

class Document {
  final String id;
  final String? tripId; // null for personal documents
  final String title;
  final String description;
  final String filePath;
  final String fileName;
  final int fileSize;
  final DocumentType type;
  final bool isPersonal;
  final DateTime createdAt;
  final DateTime updatedAt;

  Document({
    required this.id,
    this.tripId,
    required this.title,
    this.description = '',
    required this.filePath,
    required this.fileName,
    required this.fileSize,
    required this.type,
    this.isPersonal = false,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert from Drift entity
  factory Document.fromEntity(DocumentEntity entity) {
    return Document(
      id: entity.id,
      tripId: entity.tripId,
      title: entity.title,
      description: entity.description,
      filePath: entity.filePath,
      fileName: entity.fileName,
      fileSize: entity.fileSize,
      type: DocumentType.values[entity.type],
      isPersonal: entity.isPersonal,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // Convert to Drift entity
  DocumentEntity toEntity() {
    return DocumentEntity(
      id: id,
      tripId: tripId,
      title: title,
      description: description,
      filePath: filePath,
      fileName: fileName,
      fileSize: fileSize,
      type: type.index,
      isPersonal: isPersonal,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Document copyWith({
    String? id,
    String? tripId,
    String? title,
    String? description,
    String? filePath,
    String? fileName,
    int? fileSize,
    DocumentType? type,
    bool? isPersonal,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Document(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      description: description ?? this.description,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize,
      type: type ?? this.type,
      isPersonal: isPersonal ?? this.isPersonal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper getter to check if file is an image
  bool get isImage {
    final extension = fileName.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }
}