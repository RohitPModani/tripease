import 'package:drift/drift.dart';
import 'trips_table.dart';

@DataClassName('ExpenseEntity')
class ExpensesTable extends Table {
  @override
  String get tableName => 'expenses';

  TextColumn get id => text()();
  TextColumn get tripId => text().references(TripsTable, #id)();
  TextColumn get title => text().withLength(max: 255)();
  RealColumn get amount => real()();
  IntColumn get category => integer()(); // 0=transport, 1=accommodation, 2=food, 3=activities, 4=shopping, 5=other
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get paidBy => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}