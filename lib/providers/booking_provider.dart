import 'package:flutter/foundation.dart';
import '../models/booking.dart';
import '../repositories/booking_repository.dart';

class BookingProvider extends ChangeNotifier {
  final BookingRepository _repository;
  
  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _error;

  BookingProvider(this._repository);

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadBookings(String tripId) async {
    _setLoading(true);
    try {
      _bookings = await _repository.getBookingsByTripId(tripId);
      _clearError();
    } catch (e) {
      _setError('Failed to load bookings: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createBooking(Booking booking) async {
    try {
      await _repository.createBooking(booking);
      _bookings.add(booking);
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to create booking: $e');
      rethrow;
    }
  }

  Future<void> updateBooking(Booking booking) async {
    try {
      await _repository.updateBooking(booking);
      final index = _bookings.indexWhere((b) => b.id == booking.id);
      if (index != -1) {
        _bookings[index] = booking;
      }
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to update booking: $e');
      rethrow;
    }
  }

  Future<void> deleteBooking(String bookingId) async {
    try {
      await _repository.deleteBooking(bookingId);
      _bookings.removeWhere((booking) => booking.id == bookingId);
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to delete booking: $e');
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