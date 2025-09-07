import 'package:drift/drift.dart';
import 'trips_table.dart';

@DataClassName('DocumentEntity')
class DocumentsTable extends Table {
  @override
  String get tableName => 'documents';

  TextColumn get id => text()();
  TextColumn get tripId => text().nullable().references(TripsTable, #id)(); // null for personal documents
  TextColumn get title => text().withLength(max: 255)();
  TextColumn get filePath => text()();
  TextColumn get fileName => text()();
  IntColumn get fileSize => integer()();
  IntColumn get type => integer()(); // 0=passport, 1=visa, 2=ticket, 3=hotel, 4=insurance, 5=other
  BoolColumn get isPersonal => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}