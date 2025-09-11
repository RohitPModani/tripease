import 'package:flutter/material.dart';
import '../database/database.dart';
import '../database/tables/itinerary_table.dart';

class ItineraryActivity {
  final String id;
  final String tripId;
  final String title;
  final ActivityType type;
  final String description;
  final String location;
  final DateTime date;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  ItineraryActivity({
    required this.id,
    required this.tripId,
    required this.title,
    required this.type,
    this.description = '',
    this.location = '',
    required this.date,
    this.startTime,
    this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert from database entity
  factory ItineraryActivity.fromEntity(ItineraryEntity entity) {
    TimeOfDay? startTime;
    if (entity.startTimeHour != null && entity.startTimeMinute != null) {
      startTime = TimeOfDay(hour: entity.startTimeHour!, minute: entity.startTimeMinute!);
    }

    TimeOfDay? endTime;
    if (entity.endTimeHour != null && entity.endTimeMinute != null) {
      endTime = TimeOfDay(hour: entity.endTimeHour!, minute: entity.endTimeMinute!);
    }

    return ItineraryActivity(
      id: entity.id,
      tripId: entity.tripId,
      title: entity.title,
      type: entity.type,
      description: entity.description,
      location: entity.location,
      date: entity.date,
      startTime: startTime,
      endTime: endTime,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // Convert to database entity
  ItineraryEntity toEntity() {
    return ItineraryEntity(
      id: id,
      tripId: tripId,
      title: title,
      type: type,
      description: description,
      location: location,
      date: date,
      startTimeHour: startTime?.hour,
      startTimeMinute: startTime?.minute,
      endTimeHour: endTime?.hour,
      endTimeMinute: endTime?.minute,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  ItineraryActivity copyWith({
    String? id,
    String? tripId,
    String? title,
    ActivityType? type,
    String? description,
    String? location,
    DateTime? date,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ItineraryActivity(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      location: location ?? this.location,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ItineraryDay {
  final DateTime date;
  final int dayNumber;
  final List<ItineraryActivity> activities;

  ItineraryDay({
    required this.date,
    required this.dayNumber,
    required this.activities,
  });
}