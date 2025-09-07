import 'dart:convert';
import '../database/database.dart';
import 'attachment.dart';

enum BookingType { flight, hotel, activity, transport, restaurant, other }
enum BookingStatus { confirmed, pending, cancelled }

class Booking {
  final String id;
  final String tripId;
  final String title;
  final BookingType type;
  final String description;
  final DateTime? bookingDate;
  final String vendor;
  final String confirmationNumber;
  final double amount;
  final BookingStatus status;
  final List<BookingAttachment> attachments;
  final DateTime createdAt;
  final DateTime updatedAt;

  Booking({
    required this.id,
    required this.tripId,
    required this.title,
    required this.type,
    this.description = '',
    this.bookingDate,
    this.vendor = '',
    this.confirmationNumber = '',
    this.amount = 0.0,
    this.status = BookingStatus.pending,
    this.attachments = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert from Drift entity
  factory Booking.fromEntity(BookingEntity entity) {
    List<BookingAttachment> attachmentList = [];
    if (entity.attachments != null && entity.attachments!.isNotEmpty) {
      try {
        final List<dynamic> jsonList = jsonDecode(entity.attachments!);
        attachmentList = jsonList.map((json) => BookingAttachment.fromJson(json)).toList();
      } catch (e) {
        // If JSON parsing fails, leave attachments empty
        attachmentList = [];
      }
    }

    return Booking(
      id: entity.id,
      tripId: entity.tripId,
      title: entity.title,
      type: BookingType.values[entity.type],
      description: entity.description,
      bookingDate: entity.bookingDate,
      vendor: entity.vendor,
      confirmationNumber: entity.confirmationNumber,
      amount: entity.amount,
      status: BookingStatus.values[entity.status],
      attachments: attachmentList,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // Convert to Drift entity
  BookingEntity toEntity() {
    String? attachmentsJson;
    if (attachments.isNotEmpty) {
      attachmentsJson = jsonEncode(attachments.map((a) => a.toJson()).toList());
    }

    return BookingEntity(
      id: id,
      tripId: tripId,
      title: title,
      type: type.index,
      description: description,
      bookingDate: bookingDate,
      vendor: vendor,
      confirmationNumber: confirmationNumber,
      amount: amount,
      status: status.index,
      attachments: attachmentsJson,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Booking copyWith({
    String? id,
    String? tripId,
    String? title,
    BookingType? type,
    String? description,
    DateTime? bookingDate,
    String? vendor,
    String? confirmationNumber,
    double? amount,
    BookingStatus? status,
    List<BookingAttachment>? attachments,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Booking(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      bookingDate: bookingDate ?? this.bookingDate,
      vendor: vendor ?? this.vendor,
      confirmationNumber: confirmationNumber ?? this.confirmationNumber,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      attachments: attachments ?? this.attachments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}