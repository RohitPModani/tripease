import '../database/database.dart';
import '../models/todo_item.dart';
import 'package:drift/drift.dart';

class TodoRepository {
  final AppDatabase _database;

  TodoRepository(this._database);

  // Create a new todo item
  Future<void> createTodo(TodoItem todo) async {
    await _database.into(_database.todoItemsTable).insert(todo.toEntity());
  }

  // Get all todos for a trip
  Future<List<TodoItem>> getTodosByTripId(String tripId) async {
    final entities = await (_database.select(_database.todoItemsTable)
          ..where((t) => t.tripId.equals(tripId))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)]))
        .get();
    return entities.map((entity) => TodoItem.fromEntity(entity)).toList();
  }

  // Get todo by ID
  Future<TodoItem?> getTodoById(String todoId) async {
    final entity = await (_database.select(_database.todoItemsTable)
          ..where((t) => t.id.equals(todoId)))
        .getSingleOrNull();
    return entity != null ? TodoItem.fromEntity(entity) : null;
  }

  // Update todo
  Future<void> updateTodo(TodoItem todo) async {
    await (_database.update(_database.todoItemsTable)
          ..where((t) => t.id.equals(todo.id)))
        .write(todo.toEntity());
  }

  // Delete todo
  Future<void> deleteTodo(String todoId) async {
    await (_database.delete(_database.todoItemsTable)
          ..where((t) => t.id.equals(todoId)))
        .go();
  }

  // Get todos by priority
  Future<List<TodoItem>> getTodosByPriority(String tripId, Priority priority) async {
    final entities = await (_database.select(_database.todoItemsTable)
          ..where((t) => 
              t.tripId.equals(tripId) & 
              t.priority.equals(priority.index))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)]))
        .get();
    return entities.map((entity) => TodoItem.fromEntity(entity)).toList();
  }

  // Get completed todos for a trip
  Future<List<TodoItem>> getCompletedTodos(String tripId) async {
    final entities = await (_database.select(_database.todoItemsTable)
          ..where((t) => 
              t.tripId.equals(tripId) & 
              t.isCompleted.equals(true))
          ..orderBy([(t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.desc)]))
        .get();
    return entities.map((entity) => TodoItem.fromEntity(entity)).toList();
  }

  // Get pending todos for a trip
  Future<List<TodoItem>> getPendingTodos(String tripId) async {
    final entities = await (_database.select(_database.todoItemsTable)
          ..where((t) => 
              t.tripId.equals(tripId) & 
              t.isCompleted.equals(false))
          ..orderBy([
            (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.dueDate, mode: OrderingMode.asc),
          ]))
        .get();
    return entities.map((entity) => TodoItem.fromEntity(entity)).toList();
  }

  // Get overdue todos
  Future<List<TodoItem>> getOverdueTodos(String tripId) async {
    final now = DateTime.now();
    final entities = await (_database.select(_database.todoItemsTable)
          ..where((t) => 
              t.tripId.equals(tripId) & 
              t.isCompleted.equals(false) &
              t.dueDate.isSmallerThanValue(now))
          ..orderBy([(t) => OrderingTerm(expression: t.dueDate)]))
        .get();
    return entities.map((entity) => TodoItem.fromEntity(entity)).toList();
  }

  // Mark todo as completed
  Future<void> markTodoCompleted(String todoId) async {
    await (_database.update(_database.todoItemsTable)
          ..where((t) => t.id.equals(todoId)))
        .write(TodoItemsTableCompanion(
          isCompleted: const Value(true),
          updatedAt: Value(DateTime.now()),
        ));
  }

  // Mark todo as incomplete
  Future<void> markTodoIncomplete(String todoId) async {
    await (_database.update(_database.todoItemsTable)
          ..where((t) => t.id.equals(todoId)))
        .write(TodoItemsTableCompanion(
          isCompleted: const Value(false),
          updatedAt: Value(DateTime.now()),
        ));
  }

  // Get todo statistics for a trip
  Future<Map<String, int>> getTodoStats(String tripId) async {
    final allTodos = await getTodosByTripId(tripId);
    final completed = allTodos.where((t) => t.isCompleted).length;
    final pending = allTodos.where((t) => !t.isCompleted).length;
    final overdue = allTodos.where((t) => 
        !t.isCompleted && 
        t.dueDate != null && 
        t.dueDate!.isBefore(DateTime.now())).length;

    return {
      'total': allTodos.length,
      'completed': completed,
      'pending': pending,
      'overdue': overdue,
    };
  }
}