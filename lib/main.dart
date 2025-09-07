import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';
import 'repositories/trip_repository.dart';
import 'repositories/todo_repository.dart';
import 'repositories/booking_repository.dart';
import 'repositories/expense_repository.dart';
import 'repositories/document_repository.dart';
import 'providers/trip_provider.dart';
import 'providers/todo_provider.dart';
import 'providers/booking_provider.dart';
import 'providers/expense_provider.dart';
import 'providers/document_provider.dart';
import 'themes/app_theme.dart';
import 'screens/main_screen.dart';
import 'screens/create_trip_screen.dart';
import 'screens/trip_detail_screen.dart';
import 'providers/localization_provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database
  final database = AppDatabase();
  
  // Initialize repositories
  final tripRepository = TripRepository(database);
  final todoRepository = TodoRepository(database);
  final bookingRepository = BookingRepository(database);
  final expenseRepository = ExpenseRepository(database);
  final documentRepository = DocumentRepository(database);
  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => TripProvider(tripRepository)),
        ChangeNotifierProvider(create: (_) => TodoProvider(todoRepository)),
        ChangeNotifierProvider(create: (_) => BookingProvider(bookingRepository)),
        ChangeNotifierProvider(create: (_) => ExpenseProvider(expenseRepository)),
        ChangeNotifierProvider(create: (_) => DocumentProvider(documentRepository)),
      ],
      child: const TripeaseApp(),
    ),
  );
}

class TripeaseApp extends StatelessWidget {
  const TripeaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, child) {
        return MaterialApp(
          title: 'Tripease',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          locale: localizationProvider.currentLocale,
          // localizationsDelegates: const [
          //   AppLocalizations.delegate,
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // supportedLocales: localizationProvider.supportedLocales,
          home: const MainScreen(),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/main':
                return MaterialPageRoute(builder: (_) => const MainScreen());
              case '/create-trip':
                return MaterialPageRoute(builder: (_) => const CreateTripScreen());
              case '/trip-detail':
                final tripId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (_) => TripDetailScreen(tripId: tripId),
                );
              default:
                return MaterialPageRoute(builder: (_) => const MainScreen());
            }
          },
        );
      },
    );
  }
}
