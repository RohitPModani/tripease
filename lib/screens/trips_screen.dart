import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../themes/app_theme.dart';
import '../widgets/trip_card.dart';
import '../providers/trip_provider.dart';
import '../models/trip.dart';
import '../l10n/app_localizations.dart';
import 'edit_trip_screen.dart';
import 'create_trip_screen.dart';
import '../utils/snackbar.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

enum TripFilter { all, upcoming, active, completed }

class _TripsScreenState extends State<TripsScreen> {
  String _searchQuery = '';
  TripFilter _selectedFilter = TripFilter.all;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TripProvider>(context, listen: false).loadTrips();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: AppTheme.glowingButtonDecoration,
        child: FloatingActionButton.extended(
          heroTag: "create_trip_fab",
          onPressed: () {
            CreateTripScreen.show(context);
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(
            Iconsax.add,
            color: Colors.white,
          ),
          label: Text(
            AppLocalizations.of(context)!.createTrip,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  ? AppTheme.surfaceDark.withValues(alpha: 0.8)
                  : AppTheme.surfaceLight.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              // Unfocus search bar when tapping outside
              FocusScope.of(context).unfocus();
            },
            child: CustomScrollView(
              slivers: [
                _buildAppBar(context),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildSearchBar(),
                      const SizedBox(height: 16),
                      _buildFilterChips(),
                      const SizedBox(height: 24),
                      _buildYourTripsHeader(),
                    ]),
                  ),
                ),
                _buildTripsList(),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverAppBar(
      expandedHeight: 80,
      floating: true,
      pinned: true,
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            foreground: Paint()
              ..shader = AppTheme.primaryGradient.createShader(
                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
          ),
        ),
      ),
    );
  }


  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.surfaceDark
            : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.searchTrips,
          prefixIcon: const Icon(Iconsax.search_normal_1),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Iconsax.close_circle),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) {
        final trips = tripProvider.trips;
        final upcomingTrips = trips.where((trip) => trip.daysUntilStart > 0).length;
        final activeTrips = trips.where((trip) => trip.isActive).length;
        final completedTrips = trips.where((trip) => trip.isCompleted).length;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: [
                FilterChip(
                  label: Text(AppLocalizations.of(context)!.allWithTotal(trips.length)),
                  selected: _selectedFilter == TripFilter.all,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = TripFilter.all;
                    });
                  },
                  selectedColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                  checkmarkColor: AppTheme.primaryColor,
                  labelStyle: TextStyle(
                    color: _selectedFilter == TripFilter.all ? AppTheme.primaryColor : null,
                    fontWeight: _selectedFilter == TripFilter.all ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(AppLocalizations.of(context)!.upcomingWithCount(upcomingTrips)),
                  selected: _selectedFilter == TripFilter.upcoming,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = TripFilter.upcoming;
                    });
                  },
                  selectedColor: AppTheme.accentColor.withValues(alpha: 0.2),
                  checkmarkColor: AppTheme.accentColor,
                  labelStyle: TextStyle(
                    color: _selectedFilter == TripFilter.upcoming ? AppTheme.accentColor : null,
                    fontWeight: _selectedFilter == TripFilter.upcoming ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(AppLocalizations.of(context)!.activeWithCount(activeTrips)),
                  selected: _selectedFilter == TripFilter.active,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = TripFilter.active;
                    });
                  },
                  selectedColor: AppTheme.success.withValues(alpha: 0.2),
                  checkmarkColor: AppTheme.success,
                  labelStyle: TextStyle(
                    color: _selectedFilter == TripFilter.active ? AppTheme.success : null,
                    fontWeight: _selectedFilter == TripFilter.active ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(AppLocalizations.of(context)!.completedWithCount(completedTrips)),
                  selected: _selectedFilter == TripFilter.completed,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = TripFilter.completed;
                    });
                  },
                  selectedColor: AppTheme.textSecondary.withValues(alpha: 0.2),
                  checkmarkColor: AppTheme.textSecondary,
                  labelStyle: TextStyle(
                    color: _selectedFilter == TripFilter.completed ? AppTheme.textSecondary : null,
                    fontWeight: _selectedFilter == TripFilter.completed ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
          ),
        );
      },
    );
  }

  Widget _buildYourTripsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.yourTrips,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Consumer<TripProvider>(
            builder: (context, tripProvider, child) {
              final activeTrips = tripProvider.trips.where((trip) => trip.isActive).length;
              return Text(
                AppLocalizations.of(context)!.activeTripsCount(activeTrips),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTripsList() {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) {
        if (tripProvider.isLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (tripProvider.error != null) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.warning_2,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${AppLocalizations.of(context)!.failedToLoad} trips',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tripProvider.error!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => tripProvider.loadTrips(),
                    child: Text(AppLocalizations.of(context)!.retry),
                  ),
                ],
              ),
            ),
          );
        }

        final trips = _getFilteredTrips(tripProvider.trips);

        if (tripProvider.trips.isEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.airplane,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.noDataYet,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.startPlanning,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        }

        if (trips.isEmpty && (_searchQuery.isNotEmpty || _selectedFilter != TripFilter.all)) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.search_normal_1,
                      size: 64,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.noTripsFound,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.tryAdjustingFilters,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                          _selectedFilter = TripFilter.all;
                        });
                      },
                      icon: const Icon(Iconsax.refresh),
                      label: Text(AppLocalizations.of(context)!.clearFilters),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final trip = trips[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TripCard(
                          trip: trip,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/trip-detail',
                              arguments: trip.id,
                            );
                          },
                          onEdit: () {
                            EditTripScreen.show(context, trip);
                          },
                          onDelete: () {
                            _showDeleteConfirmationDialog(trip);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: trips.length,
            ),
          ),
        );
      },
    );
  }

  List<Trip> _getFilteredTrips(List<Trip> trips) {
    List<Trip> filteredTrips = trips;

    // Filter by trip status
    switch (_selectedFilter) {
      case TripFilter.all:
        // Show all trips
        break;
      case TripFilter.upcoming:
        filteredTrips = filteredTrips.where((trip) => trip.daysUntilStart > 0).toList();
        break;
      case TripFilter.active:
        filteredTrips = filteredTrips.where((trip) => trip.isActive).toList();
        break;
      case TripFilter.completed:
        filteredTrips = filteredTrips.where((trip) => trip.isCompleted).toList();
        break;
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filteredTrips = filteredTrips.where((trip) {
        return trip.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            trip.destinations.any((dest) => dest.toLowerCase().contains(_searchQuery.toLowerCase()));
      }).toList();
    }

    // Sort trips: Active first, then upcoming by days remaining, then completed last
    filteredTrips.sort((a, b) {
      // Active trips first
      if (a.isActive && !b.isActive) return -1;
      if (!a.isActive && b.isActive) return 1;
      
      // If both are active, sort by days until start
      if (a.isActive && b.isActive) {
        return a.daysUntilStart.compareTo(b.daysUntilStart);
      }
      
      // Completed trips last
      if (a.isCompleted && !b.isCompleted) return 1;
      if (!a.isCompleted && b.isCompleted) return -1;
      
      // If both are completed, sort by end date (most recent first)
      if (a.isCompleted && b.isCompleted) {
        return b.endDate.compareTo(a.endDate);
      }
      
      // For upcoming trips, sort by days until start (soonest first)
      return a.daysUntilStart.compareTo(b.daysUntilStart);
    });

    return filteredTrips;
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
                
                if (mounted && context.mounted) {
                  showAppSnackBar(
                    context,
                    l10n.tripDeletedSuccessfully,
                    type: SnackBarType.success,
                  );
                }
              } catch (e) {
                if (mounted && context.mounted) {
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
