import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../models/trip.dart';
import '../themes/app_theme.dart';
import '../providers/trip_provider.dart';
import '../l10n/app_localizations.dart';
import 'trip_tabs/overview_tab.dart';
import 'trip_tabs/todo_tab.dart';
import 'trip_tabs/bookings_tab.dart';
import 'trip_tabs/expenses_tab.dart';
import 'trip_tabs/itinerary_tab.dart';
import 'edit_trip_screen.dart';
import '../utils/snackbar.dart';

class TripDetailScreen extends StatefulWidget {
  final String tripId;

  const TripDetailScreen({super.key, required this.tripId});

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  List<Tab> _getTabs(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      Tab(icon: const Icon(Iconsax.chart), text: l10n.overviewTabTitle),
      Tab(icon: const Icon(Iconsax.task_square), text: l10n.todoTabTitle),
      Tab(icon: const Icon(Iconsax.airplane), text: l10n.bookingsTabTitle),
      Tab(icon: const Icon(Iconsax.dollar_circle), text: l10n.expensesTabTitle),
      Tab(icon: const Icon(Iconsax.calendar_1), text: l10n.itineraryTabTitle),
    ];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TripProvider>(context, listen: false).loadTrip(widget.tripId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) {
        if (tripProvider.isLoading) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.backgroundDark
                        : AppTheme.backgroundLight,
                    Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.surfaceDark.withOpacity(0.8)
                        : AppTheme.surfaceLight.withOpacity(0.8),
                  ],
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(color: AppTheme.primaryColor),
              ),
            ),
          );
        }

        if (tripProvider.error != null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Iconsax.arrow_left),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.backgroundDark
                        : AppTheme.backgroundLight,
                    Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.surfaceDark.withOpacity(0.8)
                        : AppTheme.surfaceLight.withOpacity(0.8),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.warning_2,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.failedToLoadTrip,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tripProvider.error!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => tripProvider.loadTrip(widget.tripId),
                      child: Text(AppLocalizations.of(context)!.retry),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final trip = tripProvider.currentTrip;
        if (trip == null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Iconsax.arrow_left),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.backgroundDark
                        : AppTheme.backgroundLight,
                    Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.surfaceDark.withOpacity(0.8)
                        : AppTheme.surfaceLight.withOpacity(0.8),
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.tripNotFound,
                  style: const TextStyle(fontSize: 18, color: AppTheme.textSecondary),
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.backgroundDark
                      : AppTheme.backgroundLight,
                  Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.surfaceDark.withOpacity(0.8)
                      : AppTheme.surfaceLight.withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              children: [
                _buildAppBar(trip),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      OverviewTab(trip: trip),
                      TodoTab(trip: trip),
                      BookingsTab(trip: trip),
                      ExpensesTab(trip: trip),
                      ItineraryTab(trip: trip),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(Trip trip) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppTheme.primaryColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            trip.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppTheme.primaryColor,
            ),
          ),
          centerTitle: false,
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Iconsax.more, color: AppTheme.primaryColor),
              onSelected: (value) async {
                switch (value) {
                  case 'edit':
                    EditTripScreen.show(context, trip);
                    break;
                  case 'delete':
                    _showDeleteConfirmationDialog(trip);
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.edit_2,
                        size: 16,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(width: 12),
                      Text(AppLocalizations.of(context)!.editTrip),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(Iconsax.trash, size: 16, color: Colors.red),
                      const SizedBox(width: 12),
                      Text(
                        AppLocalizations.of(context)!.deleteTrip,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          child: TabBar(
            controller: _tabController,
            isScrollable: false,
            indicatorColor: AppTheme.primaryColor,
            indicatorWeight: 3,
            labelColor: AppTheme.primaryColor,
            unselectedLabelColor: AppTheme.textSecondary,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            tabs: _getTabs(context),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(Trip trip) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteTrip),
        content: Text(l10n.deleteTripConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              
              try {
                await Provider.of<TripProvider>(context, listen: false)
                    .deleteTrip(trip.id);
                
                if (mounted) {
                  showAppSnackBar(
                    context,
                    l10n.tripDeletedSuccessfully,
                    type: SnackBarType.success,
                  );
                  Navigator.pop(context); // Go back to previous screen
                }
              } catch (e) {
                if (mounted) {
                  showAppSnackBar(
                    context,
                    l10n.failedToDeleteTrip,
                    type: SnackBarType.error,
                  );
                }
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
