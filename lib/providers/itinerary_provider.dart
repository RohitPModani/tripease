import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/itinerary.dart';
import '../repositories/itinerary_repository.dart';
import '../database/tables/itinerary_table.dart';

class ItineraryProvider extends ChangeNotifier {
  final ItineraryRepository _repository;
  
  List<ItineraryActivity> _activities = [];
  bool _isLoading = false;
  String? _error;
  String? _currentTripId;

  ItineraryProvider(this._repository);

  List<ItineraryActivity> get activities => _activities;
  bool get isLoading => _isLoading;
  String? get error => _error;
  ItineraryRepository get repository => _repository;

  Future<void> loadActivities(String tripId) async {
    if (_currentTripId == tripId && _activities.isNotEmpty) {
      return; // Already loaded for this trip
    }

    _setLoading(true);
    _currentTripId = tripId;

    try {
      _activities = await _repository.getActivitiesByTripId(tripId);
      _clearError();
    } catch (e) {
      _setError('Failed to load activities: $e');
    } finally {
      _setLoading(false);
    }
  }

  List<ItineraryActivity> getActivitiesForDate(DateTime date) {
    return _activities
        .where((activity) =>
            activity.date.year == date.year &&
            activity.date.month == date.month &&
            activity.date.day == date.day)
        .toList();
  }

  Future<void> addActivity(ItineraryActivity activity) async {
    _setLoading(true);

    try {
      await _repository.createActivity(activity);
      _activities.add(activity);
      _sortActivities();
      _clearError();
    } catch (e) {
      _setError('Failed to add activity: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateActivity(ItineraryActivity activity) async {
    _setLoading(true);

    try {
      await _repository.updateActivity(activity);
      
      final index = _activities.indexWhere((a) => a.id == activity.id);
      if (index != -1) {
        _activities[index] = activity;
        _sortActivities();
      }
      _clearError();
    } catch (e) {
      _setError('Failed to update activity: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteActivity(String activityId) async {
    _setLoading(true);

    try {
      await _repository.deleteActivity(activityId);
      _activities.removeWhere((activity) => activity.id == activityId);
      _clearError();
    } catch (e) {
      _setError('Failed to delete activity: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _sortActivities() {
    _activities.sort((a, b) {
      final dateComparison = a.date.compareTo(b.date);
      if (dateComparison != 0) return dateComparison;

      // Sort by start time within the same date
      if (a.startTime == null && b.startTime == null) return 0;
      if (a.startTime == null) return 1;
      if (b.startTime == null) return -1;

      final aMinutes = a.startTime!.hour * 60 + a.startTime!.minute;
      final bMinutes = b.startTime!.hour * 60 + b.startTime!.minute;
      return aMinutes.compareTo(bMinutes);
    });
  }

  ItineraryActivity createActivity({
    required String tripId,
    required String title,
    required ActivityType type,
    required DateTime date,
    String description = '',
    String location = '',
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  }) {
    final now = DateTime.now();
    return ItineraryActivity(
      id: const Uuid().v4(),
      tripId: tripId,
      title: title,
      type: type,
      description: description,
      location: location,
      date: date,
      startTime: startTime,
      endTime: endTime,
      createdAt: now,
      updatedAt: now,
    );
  }

  void clearData() {
    _activities.clear();
    _currentTripId = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
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