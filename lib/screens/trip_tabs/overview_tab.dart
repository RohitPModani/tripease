import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../models/trip.dart';
import '../../models/todo_item.dart';
import '../../models/booking.dart';
import '../../models/expense.dart';
import '../../themes/app_theme.dart';
import '../../providers/todo_provider.dart';
import '../../providers/booking_provider.dart';
import '../../providers/expense_provider.dart';

class OverviewTab extends StatefulWidget {
  final Trip trip;

  const OverviewTab({super.key, required this.trip});

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false).loadTodos(widget.trip.id);
      Provider.of<BookingProvider>(context, listen: false).loadBookings(widget.trip.id);
      Provider.of<ExpenseProvider>(context, listen: false).loadExpenses(widget.trip.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<TodoProvider, BookingProvider, ExpenseProvider>(
      builder: (context, todoProvider, bookingProvider, expenseProvider, child) {
        final isLoading = todoProvider.isLoading || 
                         bookingProvider.isLoading || 
                         expenseProvider.isLoading;

        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await todoProvider.loadTodos(widget.trip.id);
            await bookingProvider.loadBookings(widget.trip.id);
            await expenseProvider.loadExpenses(widget.trip.id);
          },
          color: AppTheme.primaryColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTripInfoCard(),
                const SizedBox(height: 16),
                _buildStatsGrid(
                  todoProvider.todos,
                  bookingProvider.bookings,
                  expenseProvider.expenses,
                ),
                const SizedBox(height: 24),
                _buildQuickActionsCard(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTripInfoCard() {
    final daysLeft = widget.trip.daysUntilStart;
    final duration = widget.trip.tripDuration;

    return Container(
      decoration: BoxDecoration(
        gradient: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkCardGradient
            : AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: AppTheme.primaryColor.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            offset: const Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.calendar_1,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trip Timeline',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        daysLeft > 0
                            ? '$daysLeft days until departure'
                            : widget.trip.isActive
                                ? 'Trip is active now!'
                                : 'Trip completed',
                        style: TextStyle(
                          color: daysLeft > 0
                              ? AppTheme.primaryColor
                              : widget.trip.isActive
                                  ? Colors.green
                                  : AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    'Duration',
                    '$duration days',
                    Iconsax.clock,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoItem(
                    'Destinations',
                    '${widget.trip.destinations.length}',
                    Iconsax.location,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Trip Dates',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.trip.startDate.day}/${widget.trip.startDate.month}/${widget.trip.startDate.year} - ${widget.trip.endDate.day}/${widget.trip.endDate.month}/${widget.trip.endDate.year}',
              style: TextStyle(
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Destinations',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.trip.destinations.join(' • '),
              style: TextStyle(
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            if (widget.trip.description.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.trip.description,
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.primaryColor,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsGrid(List<TodoItem> todos, List<Booking> bookings, List<Expense> expenses) {
    final completedTodos = todos.where((todo) => todo.isCompleted).length;
    final totalExpenses = expenses.fold<double>(
      0,
      (sum, expense) => sum + expense.amount,
    );

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'To-Do Items',
            '$completedTodos/${todos.length}',
            Iconsax.task_square,
            AppTheme.primaryColor,
            todos.isEmpty ? 0.0 : completedTodos / todos.length,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Total Expenses',
            '${widget.trip.defaultCurrency} ${totalExpenses.toStringAsFixed(0)}',
            Iconsax.dollar_circle,
            AppTheme.accentColor,
            null,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    double? progress,
  ) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        gradient: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkCardGradient
            : AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: AppTheme.primaryColor.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            offset: const Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            if (progress != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: color.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 4,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkCardGradient
            : AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: AppTheme.primaryColor.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            offset: const Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.add_circle,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Actions',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Add items to your trip',
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3,
              children: [
                _buildQuickActionButton(
                  'Task',
                  Iconsax.task_square,
                  AppTheme.primaryColor,
                  () => {}, // Will implement
                ),
                _buildQuickActionButton(
                  'Booking',
                  Iconsax.airplane,
                  AppTheme.accentColor,
                  () => {}, // Will implement
                ),
                _buildQuickActionButton(
                  'Expense',
                  Iconsax.dollar_circle,
                  AppTheme.secondaryColor,
                  () => {}, // Will implement
                ),
                _buildQuickActionButton(
                  'Itinerary',
                  Iconsax.location,
                  AppTheme.warning,
                  () => {}, // Will implement
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: AppTheme.glowingButtonDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}