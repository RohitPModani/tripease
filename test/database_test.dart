import 'package:flutter_test/flutter_test.dart';
import 'package:tripease/database/database.dart';
import 'package:tripease/models/trip.dart';
import 'package:tripease/repositories/trip_repository.dart';
import 'package:uuid/uuid.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('Database Tests', () {
    late AppDatabase database;
    late TripRepository tripRepository;

    setUp(() {
      database = AppDatabase();
      tripRepository = TripRepository(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('should create and retrieve a trip', () async {
      // Create a test trip
      final trip = Trip(
        id: const Uuid().v4(),
        title: 'Test Trip',
        destinations: ['Paris', 'London'],
        startDate: DateTime.now().add(const Duration(days: 30)),
        endDate: DateTime.now().add(const Duration(days: 37)),
        description: 'A test trip for database testing',
        defaultCurrency: 'USD',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save the trip
      await tripRepository.createTrip(trip);

      // Retrieve the trip
      final retrievedTrip = await tripRepository.getTripById(trip.id);

      // Verify the trip was saved correctly
      expect(retrievedTrip, isNotNull);
      expect(retrievedTrip!.title, equals('Test Trip'));
      expect(retrievedTrip.destinations, equals(['Paris', 'London']));
      expect(retrievedTrip.description, equals('A test trip for database testing'));
    });

    test('should get all trips', () async {
      // Create multiple test trips
      final trip1 = Trip(
        id: const Uuid().v4(),
        title: 'Trip 1',
        destinations: ['Tokyo'],
        startDate: DateTime.now().add(const Duration(days: 10)),
        endDate: DateTime.now().add(const Duration(days: 15)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final trip2 = Trip(
        id: const Uuid().v4(),
        title: 'Trip 2', 
        destinations: ['New York'],
        startDate: DateTime.now().add(const Duration(days: 20)),
        endDate: DateTime.now().add(const Duration(days: 25)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save the trips
      await tripRepository.createTrip(trip1);
      await tripRepository.createTrip(trip2);

      // Retrieve all trips
      final allTrips = await tripRepository.getAllTrips();

      // Verify both trips were saved
      expect(allTrips.length, greaterThanOrEqualTo(2));
      expect(allTrips.any((t) => t.title == 'Trip 1'), isTrue);
      expect(allTrips.any((t) => t.title == 'Trip 2'), isTrue);
    });
  });
}