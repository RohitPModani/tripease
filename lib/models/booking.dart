import '../database/database.dart';

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
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert from Drift entity
  factory Booking.fromEntity(BookingEntity entity) {
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
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // Convert to Drift entity
  BookingEntity toEntity() {
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}