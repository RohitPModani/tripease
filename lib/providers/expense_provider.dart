import 'package:flutter/foundation.dart';
import '../models/expense.dart';
import '../repositories/expense_repository.dart';

class ExpenseProvider extends ChangeNotifier {
  final ExpenseRepository _repository;
  
  List<Expense> _expenses = [];
  bool _isLoading = false;
  String? _error;

  ExpenseProvider(this._repository);

  List<Expense> get expenses => _expenses;
  bool get isLoading => _isLoading;
  String? get error => _error;
  ExpenseRepository get expenseRepository => _repository;

  Future<void> loadExpenses(String tripId) async {
    _setLoading(true);
    try {
      _expenses = await _repository.getExpensesByTripId(tripId);
      _clearError();
    } catch (e) {
      _setError('Failed to load expenses: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createExpense(Expense expense) async {
    try {
      await _repository.createExpense(expense);
      _expenses.add(expense);
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to create expense: $e');
      rethrow;
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      await _repository.updateExpense(expense);
      final index = _expenses.indexWhere((e) => e.id == expense.id);
      if (index != -1) {
        _expenses[index] = expense;
      }
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to update expense: $e');
      rethrow;
    }
  }

  Future<void> deleteExpense(String expenseId) async {
    try {
      await _repository.deleteExpense(expenseId);
      _expenses.removeWhere((expense) => expense.id == expenseId);
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to delete expense: $e');
      rethrow;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  // Settlement methods
  Future<void> recordSettlement({
    required String fromUserId,
    required String toUserId,
    required double amount,
    required String tripId,
    String note = '',
  }) async {
    try {
      // Find expenses where fromUser owes toUser
      final settledSplits = <ExpenseSplit>[];
      double remainingAmount = amount;
      
      for (final expense in _expenses) {
        if (remainingAmount <= 0) break;
        
        // Look for splits where fromUser owes money to toUser (who paid)
        if (expense.paidBy.isEmpty) continue;
        
        // Find the payer's member ID (we need to match by name for now)
        // This is a simplified approach - in a real app you'd want better user matching
        
        // Check if this expense was paid by the person who should receive money
        for (final split in expense.splits) {
          if (split.userId == fromUserId && !split.isPaid && remainingAmount > 0) {
            final settlementAmount = remainingAmount >= split.amount ? split.amount : remainingAmount;
            
            if (settlementAmount >= split.amount) {
              // Full payment of this split
              await _repository.markExpenseSplitPaid(split.id, true);
              settledSplits.add(split.copyWith(isPaid: true));
              remainingAmount -= split.amount;
            } else {
              // Partial payment - need to split this split
              final remainingSplitAmount = split.amount - settlementAmount;
              
              // Update original split to paid amount
              final updatedSplit = split.copyWith(
                amount: settlementAmount,
                isPaid: true,
                updatedAt: DateTime.now(),
              );
              await _repository.updateExpenseSplit(updatedSplit);
              
              // Create new split for remaining amount
              final newSplit = ExpenseSplit(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                expenseId: split.expenseId,
                userId: split.userId,
                amount: remainingSplitAmount,
                isPaid: false,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );
              await _repository.createExpenseSplit(newSplit);
              
              settledSplits.add(updatedSplit);
              remainingAmount = 0; // Used all the settlement amount
            }
          }
        }
      }
      
      // Reload expenses to reflect changes
      await loadExpenses(tripId);
      
      _clearError();
    } catch (e) {
      _setError('Failed to record settlement: $e');
      rethrow;
    }
  }

  Future<void> markSplitPaid(String splitId) async {
    try {
      await _repository.markExpenseSplitPaid(splitId, true);
      
      // Update local state
      for (int i = 0; i < _expenses.length; i++) {
        final expense = _expenses[i];
        final updatedSplits = expense.splits.map((split) {
          if (split.id == splitId) {
            return split.copyWith(isPaid: true);
          }
          return split;
        }).toList();
        
        if (updatedSplits.any((split) => split.id == splitId)) {
          _expenses[i] = expense.copyWith(splits: updatedSplits);
          break;
        }
      }
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to mark split as paid: $e');
      rethrow;
    }
  }

  Future<void> unmarkSplitPaid(String splitId) async {
    try {
      await _repository.markExpenseSplitPaid(splitId, false);
      // Update local state
      for (int i = 0; i < _expenses.length; i++) {
        final expense = _expenses[i];
        final updatedSplits = expense.splits.map((split) {
          if (split.id == splitId) {
            return split.copyWith(isPaid: false);
          }
          return split;
        }).toList();

        if (updatedSplits.any((split) => split.id == splitId)) {
          _expenses[i] = expense.copyWith(splits: updatedSplits);
          break;
        }
      }

      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to reopen settlement: $e');
      rethrow;
    }
  }
}
