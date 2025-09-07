// Legacy storage service for backward compatibility
// All methods now use the new provider-based system

import '../models/trip.dart';
import '../models/todo_item.dart';
import '../models/booking.dart';
import '../models/expense.dart';
import '../models/document.dart';

class StorageService {
  // Initialize is now handled in main.dart
  static Future<void> init() async {
    // Database initialization is now handled by providers
  }

  // Trip methods - now deprecated, use TripProvider instead
  static Future<void> saveTrip(Trip trip) async {
    throw UnimplementedError('Use TripProvider.createTrip() or TripProvider.updateTrip() instead');
  }

  static Future<List<Trip>> getTrips() async {
    throw UnimplementedError('Use TripProvider.loadTrips() and TripProvider.trips instead');
  }

  static Future<Trip?> getTrip(String tripId) async {
    throw UnimplementedError('Use TripProvider.loadTrip() and TripProvider.currentTrip instead');
  }

  static Future<void> deleteTrip(String tripId) async {
    throw UnimplementedError('Use TripProvider.deleteTrip() instead');
  }

  // Todo methods - now deprecated, use TodoProvider instead
  static Future<void> saveTodoItem(TodoItem todo) async {
    throw UnimplementedError('Use TodoProvider.createTodo() or TodoProvider.updateTodo() instead');
  }

  static Future<List<TodoItem>> getTodoItems(String tripId) async {
    throw UnimplementedError('Use TodoProvider.loadTodos() and TodoProvider.todos instead');
  }

  static Future<void> deleteTodoItem(String todoId) async {
    throw UnimplementedError('Use TodoProvider.deleteTodo() instead');
  }

  // Booking methods - now deprecated, use BookingProvider instead
  static Future<void> saveBooking(Booking booking) async {
    throw UnimplementedError('Use BookingProvider.createBooking() or BookingProvider.updateBooking() instead');
  }

  static Future<List<Booking>> getBookings(String tripId) async {
    throw UnimplementedError('Use BookingProvider.loadBookings() and BookingProvider.bookings instead');
  }

  static Future<void> deleteBooking(String bookingId) async {
    throw UnimplementedError('Use BookingProvider.deleteBooking() instead');
  }

  // Expense methods - now deprecated, use ExpenseProvider instead
  static Future<void> saveExpense(Expense expense) async {
    throw UnimplementedError('Use ExpenseProvider.createExpense() or ExpenseProvider.updateExpense() instead');
  }

  static Future<List<Expense>> getExpenses(String tripId) async {
    throw UnimplementedError('Use ExpenseProvider.loadExpenses() and ExpenseProvider.expenses instead');
  }

  static Future<void> deleteExpense(String expenseId) async {
    throw UnimplementedError('Use ExpenseProvider.deleteExpense() instead');
  }

  // Document methods - now deprecated, use DocumentProvider instead
  static Future<void> saveDocument(Document document) async {
    throw UnimplementedError('Use DocumentProvider.createDocument() or DocumentProvider.updateDocument() instead');
  }

  static Future<List<Document>> getDocuments(String? tripId) async {
    throw UnimplementedError('Use DocumentProvider.loadDocuments() or DocumentProvider.loadPersonalDocuments() instead');
  }

  static Future<void> deleteDocument(String documentId) async {
    throw UnimplementedError('Use DocumentProvider.deleteDocument() instead');
  }
}