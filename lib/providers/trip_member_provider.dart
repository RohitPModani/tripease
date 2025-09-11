import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/trip_member.dart';
import '../repositories/trip_member_repository.dart';

class TripMemberProvider extends ChangeNotifier {
  final TripMemberRepository _repository;
  
  List<TripMember> _members = [];
  bool _isLoading = false;
  String? _error;
  String? _currentTripId;

  TripMemberProvider(this._repository);

  List<TripMember> get members => _members;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  int get memberCount => _members.length;
  bool get hasMaxMembers => _members.length >= 8; // Maximum 8 members

  Future<void> loadMembers(String tripId) async {
    if (_currentTripId == tripId && _members.isNotEmpty) {
      return; // Already loaded for this trip
    }

    _setLoading(true);
    _currentTripId = tripId;

    try {
      _members = await _repository.getMembersByTripId(tripId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _setLoading(false);
  }

  Future<TripMember?> addMember({
    required String tripId,
    required String name,
    String? email,
  }) async {
    try {
      _error = null;

      // Check if we've reached the maximum
      if (hasMaxMembers) {
        _error = 'Maximum of 8 members allowed per trip';
        notifyListeners();
        return null;
      }

      // Check if name already exists
      final nameExists = await _repository.isMemberNameTaken(tripId, name);
      if (nameExists) {
        _error = 'A member with this name already exists';
        notifyListeners();
        return null;
      }

      final member = TripMember(
        id: const Uuid().v4(),
        tripId: tripId,
        name: name.trim(),
        email: email?.trim() ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final createdMember = await _repository.createMember(member);
      _members.add(createdMember);
      notifyListeners();
      return createdMember;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<bool> updateMember(TripMember member) async {
    try {
      _error = null;

      // Check if name already exists (excluding current member)
      final nameExists = await _repository.isMemberNameTaken(
        member.tripId, 
        member.name,
        excludeMemberId: member.id,
      );
      if (nameExists) {
        _error = 'A member with this name already exists';
        notifyListeners();
        return false;
      }

      final updatedMember = member.copyWith(updatedAt: DateTime.now());
      await _repository.updateMember(updatedMember);
      
      final index = _members.indexWhere((m) => m.id == member.id);
      if (index != -1) {
        _members[index] = updatedMember;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeMember(String memberId) async {
    try {
      _error = null;
      await _repository.deleteMember(memberId);
      _members.removeWhere((member) => member.id == memberId);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getMembersWithExpenseStats(String tripId) async {
    try {
      return await _repository.getMembersWithExpenseStats(tripId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return [];
    }
  }

  // Get member by name
  TripMember? getMemberByName(String name) {
    try {
      return _members.firstWhere((member) => member.name == name);
    } catch (e) {
      return null;
    }
  }

  // Get member names for dropdowns
  List<String> get memberNames => _members.map((m) => m.name).toList();

  // Check if a name is available
  Future<bool> isNameAvailable(String tripId, String name, {String? excludeMemberId}) async {
    try {
      return !(await _repository.isMemberNameTaken(tripId, name, excludeMemberId: excludeMemberId));
    } catch (e) {
      return false;
    }
  }

  // Batch add multiple members (useful for trip creation)
  Future<bool> addMultipleMembers(String tripId, List<String> names) async {
    try {
      _error = null;
      
      if (_members.length + names.length > 8) {
        _error = 'Adding these members would exceed the maximum of 8 members';
        notifyListeners();
        return false;
      }

      final members = names.map((name) => TripMember(
        id: const Uuid().v4(),
        tripId: tripId,
        name: name.trim(),
        email: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      )).toList();

      final createdMembers = await _repository.createMembers(members);
      _members.addAll(createdMembers);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Clear current trip data
  void clearCurrentTrip() {
    _members.clear();
    _currentTripId = null;
    _error = null;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}