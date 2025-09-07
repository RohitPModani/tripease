import '../database/database.dart';
import '../models/booking.dart';
import 'package:drift/drift.dart';

class BookingRepository {
  final AppDatabase _database;

  BookingRepository(this._database);

  // Create a new booking
  Future<void> createBooking(Booking booking) async {
    await _database.into(_database.bookingsTable).insert(booking.toEntity());
  }

  // Get all bookings for a trip
  Future<List<Booking>> getBookingsByTripId(String tripId) async {
    final entities = await (_database.select(_database.bookingsTable)
          ..where((b) => b.tripId.equals(tripId))
          ..orderBy([(b) => OrderingTerm(expression: b.bookingDate, mode: OrderingMode.asc)]))
        .get();
    return entities.map((entity) => Booking.fromEntity(entity)).toList();
  }

  // Get booking by ID
  Future<Booking?> getBookingById(String bookingId) async {
    final entity = await (_database.select(_database.bookingsTable)
          ..where((b) => b.id.equals(bookingId)))
        .getSingleOrNull();
    return entity != null ? Booking.fromEntity(entity) : null;
  }

  // Update booking
  Future<void> updateBooking(Booking booking) async {
    await (_database.update(_database.bookingsTable)
          ..where((b) => b.id.equals(booking.id)))
        .write(booking.toEntity());
  }

  // Delete booking
  Future<void> deleteBooking(String bookingId) async {
    await (_database.delete(_database.bookingsTable)
          ..where((b) => b.id.equals(bookingId)))
        .go();
  }

  // Get bookings by type
  Future<List<Booking>> getBookingsByType(String tripId, BookingType type) async {
    final entities = await (_database.select(_database.bookingsTable)
          ..where((b) => 
              b.tripId.equals(tripId) & 
              b.type.equals(type.index))
          ..orderBy([(b) => OrderingTerm(expression: b.bookingDate, mode: OrderingMode.asc)]))
        .get();
    return entities.map((entity) => Booking.fromEntity(entity)).toList();
  }

  // Get bookings by status
  Future<List<Booking>> getBookingsByStatus(String tripId, BookingStatus status) async {
    final entities = await (_database.select(_database.bookingsTable)
          ..where((b) => 
              b.tripId.equals(tripId) & 
              b.status.equals(status.index))
          ..orderBy([(b) => OrderingTerm(expression: b.bookingDate, mode: OrderingMode.asc)]))
        .get();
    return entities.map((entity) => Booking.fromEntity(entity)).toList();
  }

  // Get confirmed bookings
  Future<List<Booking>> getConfirmedBookings(String tripId) async {
    return await getBookingsByStatus(tripId, BookingStatus.confirmed);
  }

  // Get pending bookings
  Future<List<Booking>> getPendingBookings(String tripId) async {
    return await getBookingsByStatus(tripId, BookingStatus.pending);
  }

  // Get bookings by date range
  Future<List<Booking>> getBookingsByDateRange(
      String tripId, DateTime startDate, DateTime endDate) async {
    final entities = await (_database.select(_database.bookingsTable)
          ..where((b) => 
              b.tripId.equals(tripId) &
              b.bookingDate.isBiggerOrEqualValue(startDate) &
              b.bookingDate.isSmallerOrEqualValue(endDate))
          ..orderBy([(b) => OrderingTerm(expression: b.bookingDate, mode: OrderingMode.asc)]))
        .get();
    return entities.map((entity) => Booking.fromEntity(entity)).toList();
  }

  // Get total booking amount for a trip
  Future<double> getTotalBookingAmount(String tripId) async {
    final result = await (_database.selectOnly(_database.bookingsTable)
          ..addColumns([_database.bookingsTable.amount.sum()])
          ..where(_database.bookingsTable.tripId.equals(tripId)))
        .getSingleOrNull();
    return result?.read(_database.bookingsTable.amount.sum()) ?? 0.0;
  }

  // Get booking statistics for a trip
  Future<Map<String, dynamic>> getBookingStats(String tripId) async {
    final allBookings = await getBookingsByTripId(tripId);
    final confirmed = allBookings.where((b) => b.status == BookingStatus.confirmed).length;
    final pending = allBookings.where((b) => b.status == BookingStatus.pending).length;
    final cancelled = allBookings.where((b) => b.status == BookingStatus.cancelled).length;
    final totalAmount = allBookings.fold<double>(0, (sum, booking) => sum + booking.amount);

    // Count by type
    final typeStats = <String, int>{};
    for (final type in BookingType.values) {
      typeStats[type.name] = allBookings.where((b) => b.type == type).length;
    }

    return {
      'total': allBookings.length,
      'confirmed': confirmed,
      'pending': pending,
      'cancelled': cancelled,
      'totalAmount': totalAmount,
      'byType': typeStats,
    };
  }

  // Update booking status
  Future<void> updateBookingStatus(String bookingId, BookingStatus status) async {
    await (_database.update(_database.bookingsTable)
          ..where((b) => b.id.equals(bookingId)))
        .write(BookingsTableCompanion(
          status: Value(status.index),
          updatedAt: Value(DateTime.now()),
        ));
  }
}