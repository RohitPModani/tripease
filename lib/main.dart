import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';
import 'models/trip.dart';
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
import 'screens/trip_detail_screen.dart';
import 'screens/edit_trip_screen.dart';
import 'providers/localization_provider.dart';
import 'providers/theme_provider.dart';
import 'l10n/app_localizations.dart';
import 'package:intl/intl.dart' as intl;

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
  
  // System UI overlay style will be set dynamically based on theme
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
    return Consumer2<ThemeProvider, LocalizationProvider>(
      builder: (context, themeProvider, localizationProvider, child) {
        // Keep intl package aligned with current locale for date/number formatting
        intl.Intl.defaultLocale = localizationProvider.currentLocale.toString();
        // Set system UI overlay style based on current theme
        final isDark = themeProvider.isCurrentlyDark(context);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          systemNavigationBarColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
          systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        ));

        return MaterialApp(
          title: 'Voythrix', // App title - not localized as it's the app name
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          locale: localizationProvider.currentLocale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MainScreen(),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/main':
                return MaterialPageRoute(builder: (_) => const MainScreen());
              case '/trip-detail':
                final tripId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (_) => TripDetailScreen(tripId: tripId),
                );
              case '/edit-trip':
                final trip = settings.arguments as Trip;
                return MaterialPageRoute(
                  builder: (_) => EditTripScreen(trip: trip),
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
