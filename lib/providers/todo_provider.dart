import 'package:flutter/foundation.dart';
import '../models/todo_item.dart';
import '../repositories/todo_repository.dart';

class TodoProvider extends ChangeNotifier {
  final TodoRepository _repository;
  
  List<TodoItem> _todos = [];
  bool _isLoading = false;
  String? _error;

  TodoProvider(this._repository);

  List<TodoItem> get todos => _todos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTodos(String tripId) async {
    _setLoading(true);
    try {
      _todos = await _repository.getTodosByTripId(tripId);
      _clearError();
    } catch (e) {
      _setError('Failed to load todos: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createTodo(TodoItem todo) async {
    try {
      await _repository.createTodo(todo);
      _todos.add(todo);
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to create todo: $e');
      rethrow;
    }
  }

  Future<void> updateTodo(TodoItem todo) async {
    try {
      await _repository.updateTodo(todo);
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = todo;
      }
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to update todo: $e');
      rethrow;
    }
  }

  Future<void> deleteTodo(String todoId) async {
    try {
      await _repository.deleteTodo(todoId);
      _todos.removeWhere((todo) => todo.id == todoId);
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to delete todo: $e');
      rethrow;
    }
  }

  Future<void> toggleTodoComplete(String todoId) async {
    final todo = _todos.firstWhere((t) => t.id == todoId);
    final updatedTodo = todo.copyWith(
      isCompleted: !todo.isCompleted,
      updatedAt: DateTime.now(),
    );
    await updateTodo(updatedTodo);
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