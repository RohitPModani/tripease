import 'dart:convert';
import '../database/database.dart';

class Trip {
  final String id;
  final String title;
  final List<String> destinations;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String defaultCurrency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> memberIds;
  final String? coverImage;

  Trip({
    required this.id,
    required this.title,
    required this.destinations,
    required this.startDate,
    required this.endDate,
    this.description = '',
    this.defaultCurrency = 'USD',
    required this.createdAt,
    required this.updatedAt,
    this.memberIds = const [],
    this.coverImage,
  });

  // Business logic methods
  int get daysUntilStart {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfTripDate = DateTime(startDate.year, startDate.month, startDate.day);
    return startOfTripDate.difference(startOfToday).inDays;
  }

  int get tripDuration {
    return endDate.difference(startDate).inDays + 1;
  }

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate.add(const Duration(days: 1)));
  }

  bool get isCompleted {
    final now = DateTime.now();
    return now.isAfter(endDate.add(const Duration(days: 1)));
  }

  // Convert from Drift entity
  factory Trip.fromEntity(TripEntity entity) {
    return Trip(
      id: entity.id,
      title: entity.title,
      destinations: List<String>.from(jsonDecode(entity.destinations)),
      startDate: entity.startDate,
      endDate: entity.endDate,
      description: entity.description,
      defaultCurrency: entity.defaultCurrency,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      memberIds: List<String>.from(jsonDecode(entity.memberIds)),
      coverImage: entity.coverImage,
    );
  }

  // Convert to Drift entity
  TripEntity toEntity() {
    return TripEntity(
      id: id,
      title: title,
      destinations: jsonEncode(destinations),
      startDate: startDate,
      endDate: endDate,
      description: description,
      defaultCurrency: defaultCurrency,
      createdAt: createdAt,
      updatedAt: updatedAt,
      memberIds: jsonEncode(memberIds),
      coverImage: coverImage,
    );
  }

  Trip copyWith({
    String? id,
    String? title,
    List<String>? destinations,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    String? defaultCurrency,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? memberIds,
    String? coverImage,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      destinations: destinations ?? this.destinations,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      memberIds: memberIds ?? this.memberIds,
      coverImage: coverImage ?? this.coverImage,
    );
  }
}