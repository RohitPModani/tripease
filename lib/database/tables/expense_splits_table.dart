import 'package:drift/drift.dart';
import 'expenses_table.dart';

@DataClassName('ExpenseSplitEntity')
class ExpenseSplitsTable extends Table {
  @override
  String get tableName => 'expense_splits';

  TextColumn get id => text()();
  TextColumn get expenseId => text().references(ExpensesTable, #id)();
  TextColumn get userId => text()();
  RealColumn get amount => real()();
  BoolColumn get isPaid => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}