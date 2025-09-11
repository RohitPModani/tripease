import 'package:drift/drift.dart';
import '../database/database.dart';
import '../models/trip_member.dart';

class TripMemberRepository {
  final AppDatabase _database;

  TripMemberRepository(this._database);

  // Create a new trip member
  Future<TripMember> createMember(TripMember member) async {
    final entity = await _database.into(_database.tripMemberTable).insertReturning(
      member.toEntity().toCompanion(true),
    );
    return TripMember.fromEntity(entity);
  }

  // Get all members for a specific trip
  Future<List<TripMember>> getMembersByTripId(String tripId) async {
    final entities = await (_database.select(_database.tripMemberTable)
          ..where((m) => m.tripId.equals(tripId))
          ..orderBy([(m) => OrderingTerm(expression: m.createdAt, mode: OrderingMode.asc)]))
        .get();
    return entities.map((entity) => TripMember.fromEntity(entity)).toList();
  }

  // Get a specific member by ID
  Future<TripMember?> getMemberById(String memberId) async {
    final entity = await (_database.select(_database.tripMemberTable)
          ..where((m) => m.id.equals(memberId)))
        .getSingleOrNull();
    return entity != null ? TripMember.fromEntity(entity) : null;
  }

  // Update a trip member
  Future<TripMember> updateMember(TripMember member) async {
    await _database.update(_database.tripMemberTable).replace(member.toEntity());
    return member;
  }

  // Delete a trip member
  Future<void> deleteMember(String memberId) async {
    await (_database.delete(_database.tripMemberTable)
          ..where((m) => m.id.equals(memberId)))
        .go();
  }

  // Delete all members for a trip
  Future<void> deleteMembersByTripId(String tripId) async {
    await (_database.delete(_database.tripMemberTable)
          ..where((m) => m.tripId.equals(tripId)))
        .go();
  }

  // Get member count for a trip
  Future<int> getMemberCountByTripId(String tripId) async {
    final query = _database.selectOnly(_database.tripMemberTable)
      ..addColumns([_database.tripMemberTable.id.count()])
      ..where(_database.tripMemberTable.tripId.equals(tripId));
    
    final result = await query.getSingle();
    return result.read(_database.tripMemberTable.id.count()) ?? 0;
  }

  // Check if member name already exists in trip
  Future<bool> isMemberNameTaken(String tripId, String name, {String? excludeMemberId}) async {
    var query = _database.select(_database.tripMemberTable)
      ..where((m) => m.tripId.equals(tripId) & m.name.equals(name));
    
    if (excludeMemberId != null) {
      query = query..where((m) => m.id.isNotValue(excludeMemberId));
    }
    
    final existing = await query.getSingleOrNull();
    return existing != null;
  }

  // Get members with their expense statistics
  Future<List<Map<String, dynamic>>> getMembersWithExpenseStats(String tripId) async {
    final members = await getMembersByTripId(tripId);
    List<Map<String, dynamic>> result = [];

    for (final member in members) {
      // Get total paid by this member
      final paidQuery = _database.selectOnly(_database.expensesTable)
        ..addColumns([_database.expensesTable.amount.sum()])
        ..where(_database.expensesTable.tripId.equals(tripId) & 
                _database.expensesTable.paidBy.equals(member.name));
      
      final paidResult = await paidQuery.getSingle();
      final totalPaid = paidResult.read(_database.expensesTable.amount.sum()) ?? 0.0;

      // Get total owed by this member (from splits)
      final owedQuery = _database.selectOnly(_database.expenseSplitsTable)
        ..addColumns([_database.expenseSplitsTable.amount.sum()])
        ..where(_database.expenseSplitsTable.userId.equals(member.name));
      
      final owedResult = await owedQuery.getSingle();
      final totalOwed = owedResult.read(_database.expenseSplitsTable.amount.sum()) ?? 0.0;

      result.add({
        'member': member,
        'totalPaid': totalPaid,
        'totalOwed': totalOwed,
        'balance': totalPaid - totalOwed, // Positive means they're owed money
      });
    }

    return result;
  }

  // Batch create members
  Future<List<TripMember>> createMembers(List<TripMember> members) async {
    final companions = members.map((m) => m.toEntity().toCompanion(true)).toList();
    await _database.batch((batch) {
      batch.insertAll(_database.tripMemberTable, companions);
    });
    return members;
  }

  // Search members by name
  Future<List<TripMember>> searchMembersByName(String tripId, String searchTerm) async {
    final entities = await (_database.select(_database.tripMemberTable)
          ..where((m) => m.tripId.equals(tripId) & 
                        m.name.like('%$searchTerm%'))
          ..orderBy([(m) => OrderingTerm(expression: m.name, mode: OrderingMode.asc)]))
        .get();
    return entities.map((entity) => TripMember.fromEntity(entity)).toList();
  }
}