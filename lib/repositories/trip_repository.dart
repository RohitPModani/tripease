import '../database/database.dart';
import '../models/trip.dart';
import 'package:drift/drift.dart';

class TripRepository {
  final AppDatabase _database;

  TripRepository(this._database);

  // Create a new trip
  Future<void> createTrip(Trip trip) async {
    await _database.into(_database.tripsTable).insert(trip.toEntity());
  }

  // Get all trips
  Future<List<Trip>> getAllTrips() async {
    final entities = await _database.select(_database.tripsTable).get();
    return entities.map((entity) => Trip.fromEntity(entity)).toList();
  }

  // Get trip by ID
  Future<Trip?> getTripById(String tripId) async {
    final entity = await (_database.select(_database.tripsTable)
          ..where((t) => t.id.equals(tripId)))
        .getSingleOrNull();
    return entity != null ? Trip.fromEntity(entity) : null;
  }

  // Update trip
  Future<void> updateTrip(Trip trip) async {
    await (_database.update(_database.tripsTable)
          ..where((t) => t.id.equals(trip.id)))
        .write(trip.toEntity());
  }

  // Delete trip
  Future<void> deleteTrip(String tripId) async {
    // Delete trip and all related data
    await _database.transaction(() async {
      // Delete related todos
      await (_database.delete(_database.todoItemsTable)
            ..where((t) => t.tripId.equals(tripId)))
          .go();
      
      // Delete related bookings
      await (_database.delete(_database.bookingsTable)
            ..where((b) => b.tripId.equals(tripId)))
          .go();
      
      // Delete related expense splits first
      final expenses = await (_database.select(_database.expensesTable)
            ..where((e) => e.tripId.equals(tripId)))
          .get();
      
      for (final expense in expenses) {
        await (_database.delete(_database.expenseSplitsTable)
              ..where((es) => es.expenseId.equals(expense.id)))
            .go();
      }
      
      // Delete related expenses
      await (_database.delete(_database.expensesTable)
            ..where((e) => e.tripId.equals(tripId)))
          .go();
      
      // Delete related documents
      await (_database.delete(_database.documentsTable)
            ..where((d) => d.tripId.equals(tripId)))
          .go();
      
      // Finally delete the trip
      await (_database.delete(_database.tripsTable)
            ..where((t) => t.id.equals(tripId)))
          .go();
    });
  }

  // Get trips by date range
  Future<List<Trip>> getTripsByDateRange(DateTime startDate, DateTime endDate) async {
    final entities = await (_database.select(_database.tripsTable)
          ..where((t) => 
              t.startDate.isBiggerOrEqualValue(startDate) &
              t.endDate.isSmallerOrEqualValue(endDate)))
        .get();
    return entities.map((entity) => Trip.fromEntity(entity)).toList();
  }

  // Get active trips
  Future<List<Trip>> getActiveTrips() async {
    final now = DateTime.now();
    final entities = await (_database.select(_database.tripsTable)
          ..where((t) => 
              t.startDate.isSmallerOrEqualValue(now) &
              t.endDate.isBiggerOrEqualValue(now)))
        .get();
    return entities.map((entity) => Trip.fromEntity(entity)).toList();
  }

  // Get upcoming trips
  Future<List<Trip>> getUpcomingTrips() async {
    final now = DateTime.now();
    final entities = await (_database.select(_database.tripsTable)
          ..where((t) => t.startDate.isBiggerThanValue(now))
          ..orderBy([(t) => OrderingTerm(expression: t.startDate)]))
        .get();
    return entities.map((entity) => Trip.fromEntity(entity)).toList();
  }
}