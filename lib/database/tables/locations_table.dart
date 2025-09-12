import 'package:drift/drift.dart';

class LocationsTable extends Table {
  @override
  String get tableName => 'locations';

  // Primary key
  IntColumn get id => integer().autoIncrement()();
  
  // Location data from OpenStreetMap
  TextColumn get placeId => text().nullable()(); // OSM place_id if available
  TextColumn get displayName => text()(); // Full display name
  TextColumn get name => text().nullable()(); // Short name
  TextColumn get city => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get countryCode => text().nullable()();
  
  // Geographic coordinates
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  
  // Search optimization
  TextColumn get searchTerms => text()(); // Normalized search terms for faster lookup
  IntColumn get searchCount => integer().withDefault(const Constant(1))(); // Track popularity
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastUsed => dateTime().withDefault(currentDateAndTime)();
  
  
  @override
  List<Set<Column>> get uniqueKeys => [
    {displayName}, // Prevent duplicate entries
  ];
}