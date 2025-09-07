import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../themes/app_theme.dart';
import '../widgets/quick_stats_card.dart';
import '../widgets/search_filter_bar.dart';
import '../widgets/trip_card.dart';
import '../providers/trip_provider.dart';
import '../models/trip.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  String _searchQuery = '';
  String _sortBy = 'daysUntilStart';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TripProvider>(context, listen: false).loadTrips();
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildAppBar(context),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildQuickStats(),
                    const SizedBox(height: 24),
                    _buildSearchAndFilter(),
                    const SizedBox(height: 24),
                    _buildYourTripsHeader(),
                    const SizedBox(height: 16),
                  ]),
                ),
              ),
              _buildTripsList(),
              const SliverToBoxAdapter(
                child: SizedBox(height: 120),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 80,
      floating: true,
      pinned: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: Text(
          'Tripease',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            foreground: Paint()
              ..shader = AppTheme.primaryGradient.createShader(
                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {
              // TODO: Implement notifications
            },
            icon: const Icon(
              Iconsax.notification,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return const QuickStatsCard();
  }

  Widget _buildSearchAndFilter() {
    return SearchFilterBar(
      searchQuery: _searchQuery,
      sortBy: _sortBy,
      onSearchChanged: (query) {
        setState(() {
          _searchQuery = query;
        });
      },
      onSortChanged: (sort) {
        setState(() {
          _sortBy = sort;
        });
      },
    );
  }

  Widget _buildYourTripsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Your Trips',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Consumer<TripProvider>(
            builder: (context, tripProvider, child) {
              final activeTrips = tripProvider.trips.where((trip) => trip.isActive).length;
              return Text(
                '$activeTrips Active',
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
                    'Failed to load trips',
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
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final trips = _getFilteredTrips(tripProvider.trips);

        if (trips.isEmpty) {
          return SliverToBoxAdapter(
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
                    'No trips yet',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start planning your next adventure!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/create-trip');
                    },
                    icon: const Icon(Iconsax.add),
                    label: const Text('Create Trip'),
                  ),
                ],
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
                          title: trip.title,
                          destinations: trip.destinations,
                          startDate: trip.startDate,
                          endDate: trip.endDate,
                          daysUntilStart: trip.daysUntilStart,
                          isActive: trip.isActive,
                          completedTasks: 0, // TODO: Get from TodoProvider
                          totalTasks: 0, // TODO: Get from TodoProvider
                          totalExpense: 0.0, // TODO: Get from ExpenseProvider
                          currency: trip.defaultCurrency,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/trip-detail',
                              arguments: trip.id,
                            );
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

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filteredTrips = filteredTrips.where((trip) {
        return trip.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            trip.destinations.any((dest) => dest.toLowerCase().contains(_searchQuery.toLowerCase()));
      }).toList();
    }

    // Sort trips
    switch (_sortBy) {
      case 'daysUntilStart':
        filteredTrips.sort((a, b) => a.daysUntilStart.compareTo(b.daysUntilStart));
        break;
      case 'title':
        filteredTrips.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'startDate':
        filteredTrips.sort((a, b) => a.startDate.compareTo(b.startDate));
        break;
    }

    return filteredTrips;
  }

}