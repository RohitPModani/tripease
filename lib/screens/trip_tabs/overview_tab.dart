import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../models/trip.dart';
import '../../models/todo_item.dart';
import '../../models/expense.dart';
import '../../themes/app_theme.dart';
import '../../providers/todo_provider.dart';
import '../../providers/booking_provider.dart';
import '../../providers/expense_provider.dart';
import '../../widgets/todo_form_modal.dart';
import '../../widgets/booking_form_modal.dart';
import '../../widgets/expense_form_modal.dart';
import '../../widgets/itinerary_form_modal.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/currency_formatter.dart';
import '../../utils/snackbar.dart';

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
      Provider.of<TodoProvider>(
        context,
        listen: false,
      ).loadTodos(widget.trip.id);
      Provider.of<BookingProvider>(
        context,
        listen: false,
      ).loadBookings(widget.trip.id);
      Provider.of<ExpenseProvider>(
        context,
        listen: false,
      ).loadExpenses(widget.trip.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<TodoProvider, BookingProvider, ExpenseProvider>(
      builder:
          (context, todoProvider, bookingProvider, expenseProvider, child) {
            final isLoading =
                todoProvider.isLoading ||
                bookingProvider.isLoading ||
                expenseProvider.isLoading;

            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppTheme.primaryColor),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                await todoProvider.loadTodos(widget.trip.id);
                await expenseProvider.loadExpenses(widget.trip.id);
              },
              color: AppTheme.primaryColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQuickActionsCard(),
                    const SizedBox(height: 16),
                    _buildStatsGrid(
                      todoProvider.todos,
                      expenseProvider.expenses,
                    ),
                    const SizedBox(height: 16),
                    _buildTripInfoCard(),
                    const SizedBox(height: 16),
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
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 1.5,
          color: AppTheme.primaryColor.withValues(alpha: 0.2),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.darkCardGradient
              : AppTheme.cardGradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: AppTheme.primaryColor.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withValues(alpha: 0.08),
              offset: const Offset(0, 12),
              blurRadius: 32,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoItem(
                AppLocalizations.of(context)!.duration,
                '$duration days',
                Iconsax.clock,
                AppTheme.primaryColor,
              ),
              const SizedBox(height: 20),
              _buildInfoItemWithBadge(
                AppLocalizations.of(context)!.tripDates,
                _formatDateRange(widget.trip.startDate, widget.trip.endDate),
                Iconsax.calendar_1,
                AppTheme.primaryColor,
                daysLeft,
                widget.trip.isActive,
              ),
              const SizedBox(height: 16),
              _buildInfoItem(
                AppLocalizations.of(context)!.destinations,
                widget.trip.destinations.join(' • '),
                Iconsax.location,
                AppTheme.primaryColor,
              ),
              if (widget.trip.description.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.trip.description,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.textSecondaryDark
                        : AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.08), color.withValues(alpha: 0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.textSecondaryDark
                        : AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(List<TodoItem> todos, List<Expense> expenses) {
    final completedTodos = todos.where((todo) => todo.isCompleted).length;
    final totalExpenses = expenses.fold<double>(
      0,
      (sum, expense) => sum + expense.amount,
    );

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            AppLocalizations.of(context)!.toDoItems,
            '$completedTodos/${todos.length}',
            Iconsax.task_square,
            AppTheme.primaryColor,
            todos.isEmpty ? 0.0 : completedTodos / todos.length,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            AppLocalizations.of(context)!.totalExpenses,
            CurrencyFormatter.formatAmount(
              totalExpenses,
              widget.trip.defaultCurrency,
            ),
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
          color: AppTheme.primaryColor.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
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
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(icon, color: color, size: 16),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.textSecondaryDark
                          : AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            if (progress != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: color.withValues(alpha: 0.1),
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: AppTheme.primaryColor.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.08),
            offset: const Offset(0, 12),
            blurRadius: 32,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryColor.withValues(alpha: 0.15),
                        AppTheme.primaryColor.withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.primaryColor.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Iconsax.add_circle,
                    color: AppTheme.primaryColor,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.quickActions,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        AppLocalizations.of(context)!.addNewItemsToTrip,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.textSecondaryDark
                              : AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickActionButton(
                    AppLocalizations.of(context)!.task,
                    Iconsax.task_square,
                    AppTheme.primaryColor,
                    () => TodoFormModal.show(context, widget.trip.id),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildQuickActionButton(
                    AppLocalizations.of(context)!.booking,
                    Iconsax.airplane,
                    AppTheme.secondaryColor,
                    () => _handleAddBooking(
                      Provider.of<BookingProvider>(context, listen: false),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildQuickActionButton(
                    AppLocalizations.of(context)!.expense,
                    Iconsax.dollar_circle,
                    AppTheme.accentColor,
                    () => ExpenseFormModal.show(
                      context,
                      widget.trip.id,
                      widget.trip.defaultCurrency,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildQuickActionButton(
                    AppLocalizations.of(context)!.itinerary,
                    Iconsax.location,
                    AppTheme.warning,
                    () => ItineraryFormModal.show(
                      context,
                      widget.trip.id,
                      (activity, date) {
                        showAppSnackBar(
                          context,
                          'Activity "${activity.title}" added for ${date.day}/${date.month}/${date.year}',
                          type: SnackBarType.success,
                        );
                      },
                      selectedDate:
                          null, // Let the modal use trip start date as default
                      tripStartDate: widget.trip.startDate,
                      tripEndDate: widget.trip.endDate,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          splashColor: color.withValues(alpha: 0.1),
          highlightColor: color.withValues(alpha: 0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItemWithBadge(
    String label,
    String value,
    IconData icon,
    Color color,
    int daysLeft,
    bool isActive,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.08), color.withValues(alpha: 0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.textSecondaryDark
                            : AppTheme.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: daysLeft > 0
                              ? [
                                  AppTheme.accentColor.withValues(alpha: 0.2),
                                  AppTheme.accentColor.withValues(alpha: 0.1),
                                ]
                              : isActive
                              ? [
                                  AppTheme.success.withValues(alpha: 0.2),
                                  AppTheme.success.withValues(alpha: 0.1),
                                ]
                              : [
                                  (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppTheme.textSecondaryDark
                                          : AppTheme.textSecondary)
                                      .withValues(alpha: 0.2),
                                  (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppTheme.textSecondaryDark
                                          : AppTheme.textSecondary)
                                      .withValues(alpha: 0.1),
                                ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: daysLeft > 0
                              ? AppTheme.accentColor.withValues(alpha: 0.3)
                              : isActive
                              ? AppTheme.success.withValues(alpha: 0.3)
                              : (Theme.of(context).brightness == Brightness.dark
                                        ? AppTheme.textSecondaryDark
                                        : AppTheme.textSecondary)
                                    .withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            daysLeft > 0
                                ? Iconsax.clock
                                : isActive
                                ? Iconsax.play_circle
                                : Iconsax.tick_circle,
                            size: 12,
                            color: daysLeft > 0
                                ? AppTheme.accentColor
                                : isActive
                                ? AppTheme.success
                                : (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppTheme.textSecondaryDark
                                      : AppTheme.textSecondary),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getTripStatusText(
                              daysLeft,
                              isActive,
                              widget.trip.endDate,
                            ),
                            style: TextStyle(
                              color: daysLeft > 0
                                  ? AppTheme.accentColor
                                  : isActive
                                  ? AppTheme.success
                                  : (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppTheme.textSecondaryDark
                                        : AppTheme.textSecondary),
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTripStatusText(int daysLeft, bool isActive, DateTime endDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tripEndDate = DateTime(endDate.year, endDate.month, endDate.day);

    if (today.isAfter(tripEndDate)) {
      return AppLocalizations.of(context)!.completed;
    } else if (isActive) {
      return AppLocalizations.of(context)!.activeStatus;
    } else {
      return AppLocalizations.of(context)!.daysToGo(daysLeft);
    }
  }

  String _formatDateRange(DateTime startDate, DateTime endDate) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    String formatDate(DateTime date) {
      return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
    }

    return '${formatDate(startDate)} - ${formatDate(endDate)}';
  }

  void _handleAddBooking(BookingProvider bookingProvider) {
    // Check if booking limit is reached (15 per trip)
    if (bookingProvider.bookings.length >= 15) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.bookingLimitReached),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    BookingFormModal.show(
      context,
      widget.trip.id,
      widget.trip.defaultCurrency,
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
