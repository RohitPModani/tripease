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
import 'tables/itinerary_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  TripsTable,
  TodoItemsTable,
  BookingsTable,
  ExpensesTable,
  ExpenseSplitsTable,
  DocumentsTable,
  ItineraryTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  /// Clear all data from the database (useful for development/testing)
  Future<void> clearDatabase() async {
    await delete(tripsTable).go();
    await delete(todoItemsTable).go();
    await delete(bookingsTable).go();
    await delete(expensesTable).go();
    await delete(expenseSplitsTable).go();
    await delete(documentsTable).go();
    await delete(itineraryTable).go();
  }

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
        if (from <= 2) {
          await m.addColumn(documentsTable, documentsTable.description);
        }
        if (from <= 3) {
          // Force recreation of documents table to ensure description column exists
          await m.drop(documentsTable);
          await m.create(documentsTable);
        }
        if (from <= 4) {
          await m.create(itineraryTable);
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