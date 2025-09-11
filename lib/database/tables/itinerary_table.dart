import 'package:drift/drift.dart';

@DataClassName('ItineraryEntity')
class ItineraryTable extends Table {
  TextColumn get id => text()();
  TextColumn get tripId => text()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  IntColumn get type => intEnum<ActivityType>()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get location => text().withDefault(const Constant(''))();
  DateTimeColumn get date => dateTime()();
  IntColumn get startTimeHour => integer().nullable()();
  IntColumn get startTimeMinute => integer().nullable()();
  IntColumn get endTimeHour => integer().nullable()();
  IntColumn get endTimeMinute => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY (trip_id) REFERENCES trips(id) ON DELETE CASCADE',
  ];
}

enum ActivityType {
  sightseeing,
  meal,
  transport,
  accommodation,
  shopping,
  entertainment,
  other,
}