import '../database/database.dart';

enum ExpenseCategory { transport, accommodation, food, activities, shopping, other }

class ExpenseSplit {
  final String id;
  final String expenseId;
  final String userId;
  final double amount;
  final bool isPaid;
  final DateTime createdAt;
  final DateTime updatedAt;

  ExpenseSplit({
    required this.id,
    required this.expenseId,
    required this.userId,
    required this.amount,
    this.isPaid = false,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert from Drift entity
  factory ExpenseSplit.fromEntity(ExpenseSplitEntity entity) {
    return ExpenseSplit(
      id: entity.id,
      expenseId: entity.expenseId,
      userId: entity.userId,
      amount: entity.amount,
      isPaid: entity.isPaid,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // Convert to Drift entity
  ExpenseSplitEntity toEntity() {
    return ExpenseSplitEntity(
      id: id,
      expenseId: expenseId,
      userId: userId,
      amount: amount,
      isPaid: isPaid,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  ExpenseSplit copyWith({
    String? id,
    String? expenseId,
    String? userId,
    double? amount,
    bool? isPaid,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExpenseSplit(
      id: id ?? this.id,
      expenseId: expenseId ?? this.expenseId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      isPaid: isPaid ?? this.isPaid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Expense {
  final String id;
  final String tripId;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final String description;
  final String paidBy;
  final List<ExpenseSplit> splits;
  final DateTime createdAt;
  final DateTime updatedAt;

  Expense({
    required this.id,
    required this.tripId,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.description = '',
    this.paidBy = '',
    this.splits = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  // Business logic methods
  double get paidAmount {
    return splits.where((split) => split.isPaid).fold(0, (sum, split) => sum + split.amount);
  }

  double get unpaidAmount {
    return splits.where((split) => !split.isPaid).fold(0, (sum, split) => sum + split.amount);
  }

  bool get isSettled {
    return splits.every((split) => split.isPaid);
  }

  // Convert from Drift entity
  factory Expense.fromEntity(ExpenseEntity entity) {
    return Expense(
      id: entity.id,
      tripId: entity.tripId,
      title: entity.title,
      amount: entity.amount,
      category: ExpenseCategory.values[entity.category],
      date: entity.date,
      description: entity.description,
      paidBy: entity.paidBy,
      splits: [], // Splits will be loaded separately
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // Convert to Drift entity
  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      tripId: tripId,
      title: title,
      amount: amount,
      category: category.index,
      date: date,
      description: description,
      paidBy: paidBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Expense copyWith({
    String? id,
    String? tripId,
    String? title,
    double? amount,
    ExpenseCategory? category,
    DateTime? date,
    String? description,
    String? paidBy,
    List<ExpenseSplit>? splits,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Expense(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      description: description ?? this.description,
      paidBy: paidBy ?? this.paidBy,
      splits: splits ?? this.splits,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}