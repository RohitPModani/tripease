import '../database/database.dart';
import '../models/itinerary.dart';
import 'package:drift/drift.dart';

class ItineraryRepository {
  final AppDatabase _database;

  ItineraryRepository(this._database);

  // Create a new itinerary activity
  Future<void> createActivity(ItineraryActivity activity) async {
    await _database.into(_database.itineraryTable).insert(activity.toEntity());
  }

  // Get all activities for a trip
  Future<List<ItineraryActivity>> getActivitiesByTripId(String tripId) async {
    final entities = await (_database.select(_database.itineraryTable)
          ..where((t) => t.tripId.equals(tripId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date),
            (t) => OrderingTerm(expression: t.startTimeHour, nulls: NullsOrder.last),
            (t) => OrderingTerm(expression: t.startTimeMinute, nulls: NullsOrder.last),
          ]))
        .get();
    return entities.map((entity) => ItineraryActivity.fromEntity(entity)).toList();
  }

  // Get activities for a specific date
  Future<List<ItineraryActivity>> getActivitiesByDate(String tripId, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    final entities = await (_database.select(_database.itineraryTable)
          ..where((t) => t.tripId.equals(tripId) & 
                        t.date.isBiggerOrEqualValue(startOfDay) & 
                        t.date.isSmallerThanValue(endOfDay))
          ..orderBy([
            (t) => OrderingTerm(expression: t.startTimeHour, nulls: NullsOrder.last),
            (t) => OrderingTerm(expression: t.startTimeMinute, nulls: NullsOrder.last),
          ]))
        .get();
    return entities.map((entity) => ItineraryActivity.fromEntity(entity)).toList();
  }

  // Get activity by ID
  Future<ItineraryActivity?> getActivityById(String activityId) async {
    final entity = await (_database.select(_database.itineraryTable)
          ..where((t) => t.id.equals(activityId)))
        .getSingleOrNull();
    return entity != null ? ItineraryActivity.fromEntity(entity) : null;
  }

  // Update activity
  Future<void> updateActivity(ItineraryActivity activity) async {
    await (_database.update(_database.itineraryTable)
          ..where((t) => t.id.equals(activity.id)))
        .write(activity.toEntity());
  }

  // Delete activity
  Future<void> deleteActivity(String activityId) async {
    await (_database.delete(_database.itineraryTable)
          ..where((t) => t.id.equals(activityId)))
        .go();
  }

  // Delete all activities for a trip
  Future<void> deleteActivitiesByTripId(String tripId) async {
    await (_database.delete(_database.itineraryTable)
          ..where((t) => t.tripId.equals(tripId)))
        .go();
  }
}