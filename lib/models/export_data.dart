import 'dart:convert';
import 'trip.dart';
import 'todo_item.dart';
import 'booking.dart';
import 'expense.dart';
import 'document.dart';
import 'attachment.dart';

class ExportData {
  final DateTime exportDate;
  final String appVersion;
  final List<Trip> trips;
  final List<TodoItem> todos;
  final List<Booking> bookings;
  final List<Expense> expenses;
  final List<Document> documents;
  final Map<String, dynamic> settings;

  ExportData({
    required this.exportDate,
    required this.appVersion,
    required this.trips,
    required this.todos,
    required this.bookings,
    required this.expenses,
    required this.documents,
    required this.settings,
  });

  Map<String, dynamic> toJson() {
    return {
      'exportDate': exportDate.toIso8601String(),
      'appVersion': appVersion,
      'formatVersion': '1.0',
      'dataSize': {
        'trips': trips.length,
        'todos': todos.length,
        'bookings': bookings.length,
        'expenses': expenses.length,
        'documents': documents.length,
      },
      'data': {
        'trips': trips.map((trip) => _tripToJson(trip)).toList(),
        'todos': todos.map((todo) => _todoToJson(todo)).toList(),
        'bookings': bookings.map((booking) => _bookingToJson(booking)).toList(),
        'expenses': expenses.map((expense) => _expenseToJson(expense)).toList(),
        'documents': documents.map((document) => _documentToJson(document)).toList(),
      },
      'settings': settings,
    };
  }

  factory ExportData.fromJson(Map<String, dynamic> json) {
    return ExportData(
      exportDate: DateTime.parse(json['exportDate']),
      appVersion: json['appVersion'],
      trips: (json['data']['trips'] as List)
          .map((tripJson) => _tripFromJson(tripJson))
          .toList(),
      todos: (json['data']['todos'] as List)
          .map((todoJson) => _todoFromJson(todoJson))
          .toList(),
      bookings: (json['data']['bookings'] as List)
          .map((bookingJson) => _bookingFromJson(bookingJson))
          .toList(),
      expenses: (json['data']['expenses'] as List)
          .map((expenseJson) => _expenseFromJson(expenseJson))
          .toList(),
      documents: (json['data']['documents'] as List)
          .map((documentJson) => _documentFromJson(documentJson))
          .toList(),
      settings: json['settings'] as Map<String, dynamic>,
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory ExportData.fromJsonString(String jsonString) {
    return ExportData.fromJson(jsonDecode(jsonString));
  }
  
  // Helper methods for serialization
  static Map<String, dynamic> _tripToJson(Trip trip) {
    return {
      'id': trip.id,
      'title': trip.title,
      'destinations': trip.destinations,
      'startDate': trip.startDate.toIso8601String(),
      'endDate': trip.endDate.toIso8601String(),
      'description': trip.description,
      'defaultCurrency': trip.defaultCurrency,
      'createdAt': trip.createdAt.toIso8601String(),
      'updatedAt': trip.updatedAt.toIso8601String(),
      'memberIds': trip.memberIds,
      'coverImage': trip.coverImage,
    };
  }
  
  static Trip _tripFromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      title: json['title'],
      destinations: List<String>.from(json['destinations'] ?? []),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      description: json['description'] ?? '',
      defaultCurrency: json['defaultCurrency'] ?? 'USD',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      memberIds: List<String>.from(json['memberIds'] ?? []),
      coverImage: json['coverImage'],
    );
  }
  
  static Map<String, dynamic> _todoToJson(TodoItem todo) {
    return {
      'id': todo.id,
      'tripId': todo.tripId,
      'title': todo.title,
      'description': todo.description,
      'isCompleted': todo.isCompleted,
      'priority': todo.priority.name,
      'dueDate': todo.dueDate?.toIso8601String(),
      'createdAt': todo.createdAt.toIso8601String(),
      'updatedAt': todo.updatedAt.toIso8601String(),
    };
  }
  
  static TodoItem _todoFromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      tripId: json['tripId'],
      title: json['title'],
      description: json['description'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      priority: Priority.values.firstWhere(
        (p) => p.name == json['priority'],
        orElse: () => Priority.medium,
      ),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  
  static Map<String, dynamic> _bookingToJson(Booking booking) {
    return {
      'id': booking.id,
      'tripId': booking.tripId,
      'title': booking.title,
      'type': booking.type.name,
      'status': booking.status.name,
      'description': booking.description,
      'vendor': booking.vendor,
      'confirmationNumber': booking.confirmationNumber,
      'bookingDate': booking.bookingDate?.toIso8601String(),
      'amount': booking.amount,
      'createdAt': booking.createdAt.toIso8601String(),
      'updatedAt': booking.updatedAt.toIso8601String(),
      'attachments': booking.attachments.map((a) => a.toJson()).toList(),
    };
  }
  
  static Booking _bookingFromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      tripId: json['tripId'],
      title: json['title'],
      type: BookingType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => BookingType.other,
      ),
      status: BookingStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => BookingStatus.pending,
      ),
      description: json['description'] ?? '',
      vendor: json['vendor'] ?? '',
      confirmationNumber: json['confirmationNumber'] ?? '',
      bookingDate: json['bookingDate'] != null ? DateTime.parse(json['bookingDate']) : null,
      amount: json['amount']?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      attachments: (json['attachments'] as List<dynamic>? ?? [])
          .map((a) => BookingAttachment.fromJson(a))
          .toList(),
    );
  }
  
  static Map<String, dynamic> _expenseToJson(Expense expense) {
    return {
      'id': expense.id,
      'tripId': expense.tripId,
      'title': expense.title,
      'amount': expense.amount,
      'category': expense.category.name,
      'description': expense.description,
      'date': expense.date.toIso8601String(),
      'paidBy': expense.paidBy,
      'splits': expense.splits.map((split) => {
        'id': split.id,
        'expenseId': split.expenseId,
        'userId': split.userId,
        'amount': split.amount,
        'isPaid': split.isPaid,
        'createdAt': split.createdAt.toIso8601String(),
        'updatedAt': split.updatedAt.toIso8601String(),
      }).toList(),
      'createdAt': expense.createdAt.toIso8601String(),
      'updatedAt': expense.updatedAt.toIso8601String(),
    };
  }
  
  static Expense _expenseFromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      tripId: json['tripId'],
      title: json['title'],
      amount: json['amount']?.toDouble() ?? 0.0,
      category: ExpenseCategory.values.firstWhere(
        (c) => c.name == json['category'],
        orElse: () => ExpenseCategory.other,
      ),
      description: json['description'] ?? '',
      date: DateTime.parse(json['date']),
      paidBy: json['paidBy'] ?? '',
      splits: (json['splits'] as List<dynamic>? ?? [])
          .map((split) => ExpenseSplit(
                id: split['id'],
                expenseId: split['expenseId'],
                userId: split['userId'],
                amount: split['amount']?.toDouble() ?? 0.0,
                isPaid: split['isPaid'] ?? false,
                createdAt: DateTime.parse(split['createdAt']),
                updatedAt: DateTime.parse(split['updatedAt']),
              ))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  
  static Map<String, dynamic> _documentToJson(Document document) {
    return {
      'id': document.id,
      'tripId': document.tripId,
      'title': document.title,
      'description': document.description,
      'type': document.type.name,
      'filePath': document.filePath,
      'fileName': document.fileName,
      'fileSize': document.fileSize,
      'isPersonal': document.isPersonal,
      'createdAt': document.createdAt.toIso8601String(),
      'updatedAt': document.updatedAt.toIso8601String(),
    };
  }
  
  static Document _documentFromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      tripId: json['tripId'],
      title: json['title'],
      description: json['description'] ?? '',
      type: DocumentType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => DocumentType.other,
      ),
      filePath: json['filePath'],
      fileName: json['fileName'] ?? '',
      fileSize: json['fileSize'] ?? 0,
      isPersonal: json['isPersonal'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}