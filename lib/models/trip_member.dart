import '../database/database.dart';

class TripMember {
  final String id;
  final String tripId;
  final String name;
  final String email;
  final String? avatar;
  final DateTime createdAt;
  final DateTime updatedAt;

  TripMember({
    required this.id,
    required this.tripId,
    required this.name,
    this.email = '',
    this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert from Drift entity
  factory TripMember.fromEntity(TripMemberEntity entity) {
    return TripMember(
      id: entity.id,
      tripId: entity.tripId,
      name: entity.name,
      email: entity.email,
      avatar: entity.avatar,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // Convert to Drift entity
  TripMemberEntity toEntity() {
    return TripMemberEntity(
      id: id,
      tripId: tripId,
      name: name,
      email: email,
      avatar: avatar,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  TripMember copyWith({
    String? id,
    String? tripId,
    String? name,
    String? email,
    String? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TripMember(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'TripMember(id: $id, name: $name, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TripMember && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}