import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import 'tables/trips_table.dart';
import 'tables/todo_items_table.dart';
import 'tables/bookings_table.dart';
import 'tables/expenses_table.dart';
import 'tables/expense_splits_table.dart';
import 'tables/documents_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  TripsTable,
  TodoItemsTable,
  BookingsTable,
  ExpensesTable,
  ExpenseSplitsTable,
  DocumentsTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          await m.addColumn(bookingsTable, bookingsTable.attachments);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tripease.db'));
    
    return NativeDatabase.createInBackground(file);
  });
}