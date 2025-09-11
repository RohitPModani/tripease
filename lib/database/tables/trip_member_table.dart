import 'package:drift/drift.dart';
import 'trips_table.dart';

@DataClassName('TripMemberEntity')
class TripMemberTable extends Table {
  @override
  String get tableName => 'trip_members';

  TextColumn get id => text()();
  TextColumn get tripId => text().references(TripsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get email => text().withLength(max: 100)();
  TextColumn get avatar => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}