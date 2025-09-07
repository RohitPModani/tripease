import 'package:drift/drift.dart';
import 'trips_table.dart';

@DataClassName('BookingEntity')
class BookingsTable extends Table {
  @override
  String get tableName => 'bookings';

  TextColumn get id => text()();
  TextColumn get tripId => text().references(TripsTable, #id)();
  TextColumn get title => text().withLength(max: 255)();
  IntColumn get type => integer()(); // 0=flight, 1=hotel, 2=activity, 3=transport, 4=restaurant, 5=other
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get bookingDate => dateTime().nullable()();
  TextColumn get vendor => text().withDefault(const Constant(''))();
  TextColumn get confirmationNumber => text().withDefault(const Constant(''))();
  RealColumn get amount => real().withDefault(const Constant(0.0))();
  IntColumn get status => integer()(); // 0=confirmed, 1=pending, 2=cancelled
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}