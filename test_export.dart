import 'lib/models/export_data.dart';
import 'lib/models/trip.dart';
import 'lib/models/todo_item.dart';
import 'lib/models/booking.dart';
import 'lib/models/expense.dart';
import 'lib/models/document.dart';
import 'dart:convert';

void main() async {
  print('Testing export data serialization...');
  
  // Create test data
  final trip = Trip(
    id: 'test-trip-1',
    title: 'Test Trip',
    destinations: ['Tokyo', 'Kyoto'],
    startDate: DateTime.now(),
    endDate: DateTime.now().add(Duration(days: 7)),
    description: 'A test trip',
    defaultCurrency: 'USD',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    memberIds: [],
    coverImage: null,
  );

  final todo = TodoItem(
    id: 'test-todo-1',
    tripId: 'test-trip-1',
    title: 'Test Todo',
    description: 'A test todo item',
    isCompleted: false,
    priority: Priority.medium,
    dueDate: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final booking = Booking(
    id: 'test-booking-1',
    tripId: 'test-trip-1',
    title: 'Test Booking',
    type: BookingType.flight,
    status: BookingStatus.confirmed,
    description: 'A test booking',
    vendor: 'Test Airlines',
    confirmationNumber: 'ABC123',
    bookingDate: DateTime.now(),
    amount: 500.0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    attachments: [],
  );

  final expense = Expense(
    id: 'test-expense-1',
    tripId: 'test-trip-1',
    title: 'Test Expense',
    amount: 25.50,
    category: ExpenseCategory.food,
    date: DateTime.now(),
    description: 'Test meal',
    paidBy: 'User1',
    splits: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final document = Document(
    id: 'test-doc-1',
    tripId: 'test-trip-1',
    title: 'Test Document',
    description: 'A test document',
    filePath: '/path/to/test.pdf',
    fileName: 'test.pdf',
    fileSize: 1024,
    type: DocumentType.other,
    isPersonal: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  // Create export data
  final exportData = ExportData(
    exportDate: DateTime.now(),
    appVersion: '1.0.0',
    trips: [trip],
    todos: [todo],
    bookings: [booking],
    expenses: [expense],
    documents: [document],
    settings: {'theme': 'dark', 'language': 'en'},
  );

  try {
    // Test serialization
    print('Converting to JSON...');
    final jsonString = exportData.toJsonString();
    print('JSON size: ${jsonString.length} characters');
    print('JSON created successfully!');

    // Test deserialization
    print('Testing deserialization...');
    final parsedData = ExportData.fromJsonString(jsonString);
    print('Deserialization successful!');
    print('Trips: ${parsedData.trips.length}');
    print('Todos: ${parsedData.todos.length}');
    print('Bookings: ${parsedData.bookings.length}');
    print('Expenses: ${parsedData.expenses.length}');
    print('Documents: ${parsedData.documents.length}');
    
    print('Export data model working correctly!');
  } catch (e, stackTrace) {
    print('Error testing export data: $e');
    print('Stack trace: $stackTrace');
  }
}