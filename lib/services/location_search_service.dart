import 'dart:convert';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:drift/drift.dart';

import '../database/database.dart';
import '../models/location.dart';

class LocationSearchService {
  static final LocationSearchService _instance = LocationSearchService._internal();
  factory LocationSearchService() => _instance;
  LocationSearchService._internal();

  static const String _nominatimBaseUrl = 'https://nominatim.openstreetmap.org/search';
  static const int _maxResults = 8;
  static const int _minQueryLength = 2;
  
  // Get database instance (singleton)
  final AppDatabase _database = AppDatabase();

  /// Search locations with offline-first approach
  /// 1. Search local database first
  /// 2. If insufficient results, fetch from OpenStreetMap
  /// 3. Save new results to database
  Future<List<LocationSuggestion>> searchLocations(String query) async {
    if (query.length < _minQueryLength) {
      return [];
    }

    final normalizedQuery = query.toLowerCase().trim();
    
    try {
      // Step 1: Search local database
      final localResults = await _searchLocalDatabase(normalizedQuery);
      
      // If we have enough local results, return them
      if (localResults.length >= 5) {
        print('📍 Found ${localResults.length} local results for "$query"');
        await _updateUsageForResults(localResults);
        return localResults.take(_maxResults).toList();
      }

      // Step 2: Search online if we need more results
      print('🌐 Searching online for "$query" (local: ${localResults.length})');
      final onlineResults = await _searchOpenStreetMap(query);
      
      // Step 3: Save new results to database
      final newResults = <LocationSuggestion>[];
      for (final result in onlineResults) {
        // Check if we already have this location
        if (!_isDuplicateLocation(result, localResults)) {
          await _saveLocationToDatabase(result);
          newResults.add(result);
        }
      }

      // Combine and deduplicate results
      final combinedResults = <LocationSuggestion>[];
      combinedResults.addAll(localResults);
      combinedResults.addAll(newResults);
      
      // Update usage for local results
      await _updateUsageForResults(localResults);
      
      print('✅ Returning ${combinedResults.length} results for "$query"');
      return combinedResults.take(_maxResults).toList();
      
    } catch (e) {
      print('❌ Error searching locations: $e');
      // Return local results even if online search fails
      final localResults = await _searchLocalDatabase(normalizedQuery);
      await _updateUsageForResults(localResults);
      return localResults.take(_maxResults).toList();
    }
  }

  /// Search local database using fuzzy matching
  Future<List<LocationSuggestion>> _searchLocalDatabase(String query) async {
    try {
      final db = _database;
      
      // Search by display name and search terms
      final results = await (db.select(db.locationsTable)
            ..where((table) => 
              table.displayName.lower().contains(query) |
              table.searchTerms.contains(query) |
              table.name.lower().contains(query) |
              table.city.lower().contains(query) |
              table.country.lower().contains(query)
            )
            ..orderBy([
              // Order by search count (popularity) descending, then by last used
              (table) => OrderingTerm.desc(table.searchCount),
              (table) => OrderingTerm.desc(table.lastUsed),
            ])
            ..limit(_maxResults))
          .get();

      return results.map((entity) => LocationSuggestion.fromEntity(entity)).toList();
    } catch (e) {
      print('❌ Error searching local database: $e');
      // If table doesn't exist yet, return empty results and let online search handle it
      return [];
    }
  }

  /// Search OpenStreetMap Nominatim API
  Future<List<LocationSuggestion>> _searchOpenStreetMap(String query) async {
    // Prefer device locale for result language, fallback to English
    final locale = ui.PlatformDispatcher.instance.locale;
    final acceptLanguage = locale.toLanguageTag().isNotEmpty ? locale.toLanguageTag() : 'en';

    final uri = Uri.parse(_nominatimBaseUrl).replace(queryParameters: {
      'format': 'json',
      'addressdetails': '1',
      'limit': _maxResults.toString(),
      'q': query,
      'extratags': '1',
      'namedetails': '1',
      'accept-language': acceptLanguage,
    });

    final response = await http.get(
      uri,
      headers: {
        'User-Agent': 'TripEase/1.0.0', // Required by Nominatim
      },
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((item) => LocationSuggestion.fromOSMJson(item as Map<String, dynamic>))
          .toList();
    } else {
      print('OpenStreetMap API error: ${response.statusCode}');
      return [];
    }
  }

  /// Save location to database
  Future<void> _saveLocationToDatabase(LocationSuggestion location) async {
    final db = _database;
    
    try {
      await db.into(db.locationsTable).insertOnConflictUpdate(location.toEntity());
    } catch (e) {
      print('Error saving location to database: $e');
    }
  }

  /// Update usage statistics for search results
  Future<void> _updateUsageForResults(List<LocationSuggestion> results) async {
    final db = _database;
    
    for (final result in results) {
      if (result.id != null) {
        try {
          await (db.update(db.locationsTable)
                ..where((table) => table.id.equals(result.id!)))
              .write(LocationsTableCompanion(
                searchCount: Value(result.searchCount + 1),
                lastUsed: Value(DateTime.now()),
              ));
        } catch (e) {
          print('Error updating usage for ${result.displayName}: $e');
        }
      }
    }
  }

  /// Check if a location is already in the local results
  bool _isDuplicateLocation(LocationSuggestion newLocation, List<LocationSuggestion> existingLocations) {
    return existingLocations.any((existing) =>
        existing.displayName.toLowerCase() == newLocation.displayName.toLowerCase() ||
        (existing.latitude != null && 
         newLocation.latitude != null &&
         (existing.latitude! - newLocation.latitude!).abs() < 0.01 &&
         (existing.longitude! - newLocation.longitude!).abs() < 0.01)
    );
  }

  /// Get popular/recent locations for quick suggestions
  Future<List<LocationSuggestion>> getPopularLocations({int limit = 10}) async {
    try {
      final db = _database;
      
      final results = await (db.select(db.locationsTable)
            ..orderBy([
              (table) => OrderingTerm.desc(table.searchCount),
              (table) => OrderingTerm.desc(table.lastUsed),
            ])
            ..limit(limit))
          .get();

      return results.map((entity) => LocationSuggestion.fromEntity(entity)).toList();
    } catch (e) {
      print('❌ Error getting popular locations: $e');
      // If table doesn't exist yet, initialize with common destinations
      await initializeWithCommonDestinations();
      // Return empty list for now, will be populated after initialization
      return [];
    }
  }

  /// Pre-populate database with common destinations
  Future<void> initializeWithCommonDestinations() async {
    try {
      final commonDestinations = [
        {'name': 'Paris, France', 'country': 'France', 'city': 'Paris'},
        {'name': 'London, United Kingdom', 'country': 'United Kingdom', 'city': 'London'},
        {'name': 'New York, United States', 'country': 'United States', 'city': 'New York'},
        {'name': 'Tokyo, Japan', 'country': 'Japan', 'city': 'Tokyo'},
        {'name': 'Rome, Italy', 'country': 'Italy', 'city': 'Rome'},
        {'name': 'Barcelona, Spain', 'country': 'Spain', 'city': 'Barcelona'},
        {'name': 'Amsterdam, Netherlands', 'country': 'Netherlands', 'city': 'Amsterdam'},
        {'name': 'Dubai, UAE', 'country': 'UAE', 'city': 'Dubai'},
        {'name': 'Bangkok, Thailand', 'country': 'Thailand', 'city': 'Bangkok'},
        {'name': 'Singapore', 'country': 'Singapore', 'city': 'Singapore'},
      ];

      final db = _database;
      final now = DateTime.now();
      
      // First ensure the table exists by trying to create it
      await db.customStatement('CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY AUTOINCREMENT, place_id TEXT, display_name TEXT NOT NULL, name TEXT, city TEXT, state TEXT, country TEXT, country_code TEXT, latitude REAL, longitude REAL, search_terms TEXT NOT NULL, search_count INTEGER NOT NULL DEFAULT 1, created_at INTEGER NOT NULL DEFAULT (strftime(\'%s\', \'now\')), last_used INTEGER NOT NULL DEFAULT (strftime(\'%s\', \'now\')), UNIQUE(display_name))');
      
      for (final dest in commonDestinations) {
        try {
          final location = LocationSuggestion(
            displayName: dest['name']!,
            name: dest['city'],
            city: dest['city'],
            country: dest['country'],
            searchTerms: '${dest['name']!.toLowerCase()} ${dest['city']!.toLowerCase()} ${dest['country']!.toLowerCase()}',
            searchCount: 1,
            createdAt: now,
            lastUsed: now,
          );

          await db.into(db.locationsTable).insertOnConflictUpdate(location.toEntity());
        } catch (e) {
          // Ignore duplicates or other errors
          print('Skipping destination ${dest['name']}: $e');
        }
      }
      
      print('✅ Initialized locations table with common destinations');
    } catch (e) {
      print('❌ Failed to initialize common destinations: $e');
    }
  }

  /// Clear old/unused locations to keep database lean
  Future<void> cleanupOldLocations({int keepRecent = 1000}) async {
    final db = _database;
    
    // Get IDs of locations to keep
    final keepIds = await (db.selectOnly(db.locationsTable)
      ..addColumns([db.locationsTable.id])
      ..orderBy([
        OrderingTerm.desc(db.locationsTable.searchCount),
        OrderingTerm.desc(db.locationsTable.lastUsed),
      ])
      ..limit(keepRecent))
    .map((row) => row.read(db.locationsTable.id)!)
    .get();
    
    // Delete locations not in the keep list
    await (db.delete(db.locationsTable)
          ..where((table) => table.id.isNotIn(keepIds)))
        .go();
  }
}
