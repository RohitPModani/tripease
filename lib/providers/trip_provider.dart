import 'package:flutter/foundation.dart';
import '../models/trip.dart';
import '../repositories/trip_repository.dart';

class TripProvider extends ChangeNotifier {
  final TripRepository _repository;
  
  List<Trip> _trips = [];
  Trip? _currentTrip;
  bool _isLoading = false;
  String? _error;

  TripProvider(this._repository);

  // Getters
  List<Trip> get trips => _trips;
  Trip? get currentTrip => _currentTrip;
  bool get isLoading => _isLoading;
  String? get error => _error;
  TripRepository get tripRepository => _repository;

  List<Trip> get activeTrips => _trips.where((trip) => trip.isActive).toList();
  List<Trip> get upcomingTrips => _trips.where((trip) => trip.daysUntilStart > 0).toList();
  List<Trip> get completedTrips => _trips.where((trip) => trip.isCompleted).toList();

  // Load all trips
  Future<void> loadTrips() async {
    _setLoading(true);
    try {
      _trips = await _repository.getAllTrips();
      _trips.sort((a, b) => a.startDate.compareTo(b.startDate));
      _clearError();
    } catch (e) {
      _setError('Failed to load trips: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Load trip by ID
  Future<void> loadTrip(String tripId) async {
    _setLoading(true);
    try {
      _currentTrip = await _repository.getTripById(tripId);
      _clearError();
    } catch (e) {
      _setError('Failed to load trip: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Create new trip
  Future<void> createTrip(Trip trip) async {
    _setLoading(true);
    try {
      await _repository.createTrip(trip);
      await loadTrips(); // Refresh the list
      _clearError();
    } catch (e) {
      _setError('Failed to create trip: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Update existing trip
  Future<void> updateTrip(Trip trip) async {
    _setLoading(true);
    try {
      await _repository.updateTrip(trip);
      
      // Update local state
      final index = _trips.indexWhere((t) => t.id == trip.id);
      if (index != -1) {
        _trips[index] = trip;
      }
      
      if (_currentTrip?.id == trip.id) {
        _currentTrip = trip;
      }
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to update trip: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Delete trip
  Future<void> deleteTrip(String tripId) async {
    _setLoading(true);
    try {
      await _repository.deleteTrip(tripId);
      
      // Update local state
      _trips.removeWhere((trip) => trip.id == tripId);
      
      if (_currentTrip?.id == tripId) {
        _currentTrip = null;
      }
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to delete trip: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Get trip by ID from memory (no database call)
  Trip? getTripById(String tripId) {
    try {
      return _trips.firstWhere((trip) => trip.id == tripId);
    } catch (e) {
      return null;
    }
  }

  // Search trips by title or destination
  List<Trip> searchTrips(String query) {
    if (query.isEmpty) return _trips;
    
    final lowerQuery = query.toLowerCase();
    return _trips.where((trip) =>
        trip.title.toLowerCase().contains(lowerQuery) ||
        trip.destinations.any((dest) => dest.toLowerCase().contains(lowerQuery)) ||
        trip.description.toLowerCase().contains(lowerQuery)).toList();
  }

  // Sort trips by different criteria
  void sortTrips(String sortBy) {
    switch (sortBy) {
      case 'daysUntilStart':
        _trips.sort((a, b) => a.daysUntilStart.compareTo(b.daysUntilStart));
        break;
      case 'startDate':
        _trips.sort((a, b) => a.startDate.compareTo(b.startDate));
        break;
      case 'title':
        _trips.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'duration':
        _trips.sort((a, b) => a.tripDuration.compareTo(b.tripDuration));
        break;
      case 'created':
        _trips.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }
    notifyListeners();
  }

  // Get trip statistics
  Map<String, dynamic> getTripStats() {
    final now = DateTime.now();
    final active = _trips.where((t) => t.isActive).length;
    final upcoming = _trips.where((t) => t.daysUntilStart > 0).length;
    final completed = _trips.where((t) => t.isCompleted).length;
    final thisYear = _trips.where((t) => t.startDate.year == now.year).length;

    return {
      'total': _trips.length,
      'active': active,
      'upcoming': upcoming,
      'completed': completed,
      'thisYear': thisYear,
    };
  }

  // Clear current trip
  void clearCurrentTrip() {
    _currentTrip = null;
    notifyListeners();
  }

  // Private helper methods
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