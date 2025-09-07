import 'package:drift/drift.dart';

@DataClassName('TripEntity')
class TripsTable extends Table {
  @override
  String get tableName => 'trips';

  TextColumn get id => text()();
  TextColumn get title => text().withLength(max: 255)();
  TextColumn get destinations => text()(); // JSON array of strings
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get defaultCurrency => text().withLength(max: 10).withDefault(const Constant('USD'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get memberIds => text().withDefault(const Constant('[]'))(); // JSON array of strings
  TextColumn get coverImage => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}