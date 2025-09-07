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
}