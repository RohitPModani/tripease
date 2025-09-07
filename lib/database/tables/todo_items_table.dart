import 'package:drift/drift.dart';
import 'trips_table.dart';

@DataClassName('TodoItemEntity')
class TodoItemsTable extends Table {
  @override
  String get tableName => 'todo_items';

  TextColumn get id => text()();
  TextColumn get tripId => text().references(TripsTable, #id)();
  TextColumn get title => text().withLength(max: 255)();
  TextColumn get description => text().withDefault(const Constant(''))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  IntColumn get priority => integer()(); // 0=low, 1=medium, 2=high, 3=urgent
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get assignedTo => text().withDefault(const Constant(''))();
  TextColumn get tags => text().withDefault(const Constant('[]'))(); // JSON array of strings
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}