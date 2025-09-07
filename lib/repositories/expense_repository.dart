import '../database/database.dart';
import '../models/expense.dart';
import 'package:drift/drift.dart';

class ExpenseRepository {
  final AppDatabase _database;

  ExpenseRepository(this._database);

  // Create a new expense
  Future<void> createExpense(Expense expense) async {
    await _database.transaction(() async {
      // Insert the expense
      await _database.into(_database.expensesTable).insert(expense.toEntity());
      
      // Insert splits if any
      for (final split in expense.splits) {
        await _database.into(_database.expenseSplitsTable).insert(split.toEntity());
      }
    });
  }

  // Get all expenses for a trip
  Future<List<Expense>> getExpensesByTripId(String tripId) async {
    final entities = await (_database.select(_database.expensesTable)
          ..where((e) => e.tripId.equals(tripId))
          ..orderBy([(e) => OrderingTerm(expression: e.date, mode: OrderingMode.desc)]))
        .get();
    
    final expenses = <Expense>[];
    for (final entity in entities) {
      final splits = await _getSplitsByExpenseId(entity.id);
      expenses.add(Expense.fromEntity(entity).copyWith(splits: splits));
    }
    return expenses;
  }

  // Get expense by ID
  Future<Expense?> getExpenseById(String expenseId) async {
    final entity = await (_database.select(_database.expensesTable)
          ..where((e) => e.id.equals(expenseId)))
        .getSingleOrNull();
    
    if (entity == null) return null;
    
    final splits = await _getSplitsByExpenseId(expenseId);
    return Expense.fromEntity(entity).copyWith(splits: splits);
  }

  // Update expense
  Future<void> updateExpense(Expense expense) async {
    await _database.transaction(() async {
      // Update the expense
      await (_database.update(_database.expensesTable)
            ..where((e) => e.id.equals(expense.id)))
          .write(expense.toEntity());
      
      // Delete existing splits and insert new ones
      await (_database.delete(_database.expenseSplitsTable)
            ..where((es) => es.expenseId.equals(expense.id)))
          .go();
      
      for (final split in expense.splits) {
        await _database.into(_database.expenseSplitsTable).insert(split.toEntity());
      }
    });
  }

  // Delete expense
  Future<void> deleteExpense(String expenseId) async {
    await _database.transaction(() async {
      // Delete splits first
      await (_database.delete(_database.expenseSplitsTable)
            ..where((es) => es.expenseId.equals(expenseId)))
          .go();
      
      // Delete expense
      await (_database.delete(_database.expensesTable)
            ..where((e) => e.id.equals(expenseId)))
          .go();
    });
  }

  // Get expenses by category
  Future<List<Expense>> getExpensesByCategory(String tripId, ExpenseCategory category) async {
    final entities = await (_database.select(_database.expensesTable)
          ..where((e) => 
              e.tripId.equals(tripId) & 
              e.category.equals(category.index))
          ..orderBy([(e) => OrderingTerm(expression: e.date, mode: OrderingMode.desc)]))
        .get();
    
    final expenses = <Expense>[];
    for (final entity in entities) {
      final splits = await _getSplitsByExpenseId(entity.id);
      expenses.add(Expense.fromEntity(entity).copyWith(splits: splits));
    }
    return expenses;
  }

  // Get expenses by date range
  Future<List<Expense>> getExpensesByDateRange(
      String tripId, DateTime startDate, DateTime endDate) async {
    final entities = await (_database.select(_database.expensesTable)
          ..where((e) => 
              e.tripId.equals(tripId) &
              e.date.isBiggerOrEqualValue(startDate) &
              e.date.isSmallerOrEqualValue(endDate))
          ..orderBy([(e) => OrderingTerm(expression: e.date, mode: OrderingMode.desc)]))
        .get();
    
    final expenses = <Expense>[];
    for (final entity in entities) {
      final splits = await _getSplitsByExpenseId(entity.id);
      expenses.add(Expense.fromEntity(entity).copyWith(splits: splits));
    }
    return expenses;
  }

  // Get total expenses for a trip
  Future<double> getTotalExpenses(String tripId) async {
    final result = await (_database.selectOnly(_database.expensesTable)
          ..addColumns([_database.expensesTable.amount.sum()])
          ..where(_database.expensesTable.tripId.equals(tripId)))
        .getSingleOrNull();
    return result?.read(_database.expensesTable.amount.sum()) ?? 0.0;
  }

  // Get expenses by category with totals
  Future<Map<ExpenseCategory, double>> getExpensesByCategoryWithTotals(String tripId) async {
    final expenses = await getExpensesByTripId(tripId);
    final categoryTotals = <ExpenseCategory, double>{};
    
    for (final expense in expenses) {
      categoryTotals[expense.category] = 
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }
    
    return categoryTotals;
  }

  // Get expense statistics
  Future<Map<String, dynamic>> getExpenseStats(String tripId) async {
    final expenses = await getExpensesByTripId(tripId);
    final totalAmount = expenses.fold<double>(0, (sum, expense) => sum + expense.amount);
    
    // Count and total by category
    final categoryStats = <String, Map<String, dynamic>>{};
    for (final category in ExpenseCategory.values) {
      final categoryExpenses = expenses.where((e) => e.category == category);
      final categoryTotal = categoryExpenses.fold<double>(0, (sum, e) => sum + e.amount);
      categoryStats[category.name] = {
        'count': categoryExpenses.length,
        'total': categoryTotal,
        'percentage': totalAmount > 0 ? (categoryTotal / totalAmount * 100) : 0.0,
      };
    }

    // Get expenses by person (paidBy)
    final personStats = <String, double>{};
    for (final expense in expenses) {
      final payer = expense.paidBy.isEmpty ? 'Unknown' : expense.paidBy;
      personStats[payer] = (personStats[payer] ?? 0) + expense.amount;
    }

    return {
      'total': totalAmount,
      'count': expenses.length,
      'byCategory': categoryStats,
      'byPerson': personStats,
      'averageExpense': expenses.isNotEmpty ? totalAmount / expenses.length : 0.0,
    };
  }

  // Private helper to get splits for an expense
  Future<List<ExpenseSplit>> _getSplitsByExpenseId(String expenseId) async {
    final entities = await (_database.select(_database.expenseSplitsTable)
          ..where((es) => es.expenseId.equals(expenseId)))
        .get();
    return entities.map((entity) => ExpenseSplit.fromEntity(entity)).toList();
  }

  // Create expense split
  Future<void> createExpenseSplit(ExpenseSplit split) async {
    await _database.into(_database.expenseSplitsTable).insert(split.toEntity());
  }

  // Update expense split
  Future<void> updateExpenseSplit(ExpenseSplit split) async {
    await (_database.update(_database.expenseSplitsTable)
          ..where((es) => es.id.equals(split.id)))
        .write(split.toEntity());
  }

  // Mark expense split as paid
  Future<void> markExpenseSplitPaid(String splitId, bool isPaid) async {
    await (_database.update(_database.expenseSplitsTable)
          ..where((es) => es.id.equals(splitId)))
        .write(ExpenseSplitsTableCompanion(
          isPaid: Value(isPaid),
          updatedAt: Value(DateTime.now()),
        ));
  }

  // Get unsettled expenses (with unpaid splits)
  Future<List<Expense>> getUnsettledExpenses(String tripId) async {
    final expenses = await getExpensesByTripId(tripId);
    return expenses.where((expense) => !expense.isSettled).toList();
  }
}