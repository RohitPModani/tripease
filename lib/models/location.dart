import 'package:drift/drift.dart';
import '../database/database.dart';

class LocationSuggestion {
  final int? id;
  final String? placeId;
  final String displayName;
  final String? name;
  final String? city;
  final String? state;
  final String? country;
  final String? countryCode;
  final double? latitude;
  final double? longitude;
  final String searchTerms;
  final int searchCount;
  final DateTime createdAt;
  final DateTime lastUsed;

  LocationSuggestion({
    this.id,
    this.placeId,
    required this.displayName,
    this.name,
    this.city,
    this.state,
    this.country,
    this.countryCode,
    this.latitude,
    this.longitude,
    required this.searchTerms,
    this.searchCount = 1,
    required this.createdAt,
    required this.lastUsed,
  });

  // Convert from database entity
  factory LocationSuggestion.fromEntity(LocationsTableData entity) {
    return LocationSuggestion(
      id: entity.id,
      placeId: entity.placeId,
      displayName: entity.displayName,
      name: entity.name,
      city: entity.city,
      state: entity.state,
      country: entity.country,
      countryCode: entity.countryCode,
      latitude: entity.latitude,
      longitude: entity.longitude,
      searchTerms: entity.searchTerms,
      searchCount: entity.searchCount,
      createdAt: entity.createdAt,
      lastUsed: entity.lastUsed,
    );
  }

  // Convert to database entity
  LocationsTableCompanion toEntity() {
    return LocationsTableCompanion.insert(
      placeId: Value(placeId),
      displayName: displayName,
      name: Value(name),
      city: Value(city),
      state: Value(state),
      country: Value(country),
      countryCode: Value(countryCode),
      latitude: Value(latitude),
      longitude: Value(longitude),
      searchTerms: searchTerms,
      searchCount: Value(searchCount),
      lastUsed: Value(lastUsed),
    );
  }

  // Create from OpenStreetMap API response
  factory LocationSuggestion.fromOSMJson(Map<String, dynamic> json) {
    final address = json['address'] as Map<String, dynamic>? ?? {};
    
    // Extract location components
    final city = address['city'] ?? 
                address['town'] ?? 
                address['village'] ?? 
                address['municipality'];
    
    final state = address['state'] ?? 
                 address['province'] ?? 
                 address['region'];
    
    final country = address['country'];
    final countryCode = address['country_code'];
    
    // Create search terms for better matching
    final searchTerms = _createSearchTerms(
      json['display_name'],
      city,
      state,
      country,
    );

    final now = DateTime.now();
    
    return LocationSuggestion(
      placeId: json['place_id']?.toString(),
      displayName: json['display_name'] ?? '',
      name: json['name'],
      city: city,
      state: state,
      country: country,
      countryCode: countryCode,
      latitude: double.tryParse(json['lat']?.toString() ?? ''),
      longitude: double.tryParse(json['lon']?.toString() ?? ''),
      searchTerms: searchTerms,
      createdAt: now,
      lastUsed: now,
    );
  }

  // Create normalized search terms for better matching
  static String _createSearchTerms(String? displayName, String? city, String? state, String? country) {
    final terms = <String>[];
    
    if (displayName != null) {
      terms.addAll(displayName.toLowerCase().split(RegExp(r'[,\s]+')));
    }
    if (city != null) terms.add(city.toLowerCase());
    if (state != null) terms.add(state.toLowerCase());
    if (country != null) terms.add(country.toLowerCase());
    
    return terms.where((term) => term.isNotEmpty).join(' ');
  }

  // Create a short display string for UI
  String get shortDisplayName {
    if (city != null && country != null) {
      return '$city, $country';
    } else if (country != null) {
      return country!;
    }
    return displayName;
  }

  // Copy with updated usage
  LocationSuggestion copyWithUsage() {
    return LocationSuggestion(
      id: id,
      placeId: placeId,
      displayName: displayName,
      name: name,
      city: city,
      state: state,
      country: country,
      countryCode: countryCode,
      latitude: latitude,
      longitude: longitude,
      searchTerms: searchTerms,
      searchCount: searchCount + 1,
      createdAt: createdAt,
      lastUsed: DateTime.now(),
    );
  }
}