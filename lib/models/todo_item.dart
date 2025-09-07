import 'dart:convert';
import '../database/database.dart';

enum Priority { low, medium, high, urgent }

class TodoItem {
  final String id;
  final String tripId;
  final String title;
  final String description;
  final bool isCompleted;
  final Priority priority;
  final DateTime? dueDate;
  final String assignedTo;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  TodoItem({
    required this.id,
    required this.tripId,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.priority = Priority.medium,
    this.dueDate,
    this.assignedTo = '',
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert from Drift entity
  factory TodoItem.fromEntity(TodoItemEntity entity) {
    return TodoItem(
      id: entity.id,
      tripId: entity.tripId,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      priority: Priority.values[entity.priority],
      dueDate: entity.dueDate,
      assignedTo: entity.assignedTo,
      tags: List<String>.from(jsonDecode(entity.tags)),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // Convert to Drift entity
  TodoItemEntity toEntity() {
    return TodoItemEntity(
      id: id,
      tripId: tripId,
      title: title,
      description: description,
      isCompleted: isCompleted,
      priority: priority.index,
      dueDate: dueDate,
      assignedTo: assignedTo,
      tags: jsonEncode(tags),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  TodoItem copyWith({
    String? id,
    String? tripId,
    String? title,
    String? description,
    bool? isCompleted,
    Priority? priority,
    DateTime? dueDate,
    String? assignedTo,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TodoItem(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      assignedTo: assignedTo ?? this.assignedTo,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}