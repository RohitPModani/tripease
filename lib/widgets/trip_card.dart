import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../themes/app_theme.dart';

class TripCard extends StatelessWidget {
  final String title;
  final List<String> destinations;
  final DateTime startDate;
  final DateTime endDate;
  final int daysUntilStart;
  final bool isActive;
  final int completedTasks;
  final int totalTasks;
  final double totalExpense;
  final String currency;
  final VoidCallback onTap;

  const TripCard({
    super.key,
    required this.title,
    required this.destinations,
    required this.startDate,
    required this.endDate,
    required this.daysUntilStart,
    required this.isActive,
    required this.completedTasks,
    required this.totalTasks,
    required this.totalExpense,
    required this.currency,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progressPercentage = totalTasks > 0 ? completedTasks / totalTasks : 0.0;
    
    return Container(
      decoration: isDark
          ? AppTheme.pixieCardDecorationDark
          : AppTheme.pixieCardDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 16),
                _buildDestinations(context),
                const SizedBox(height: 16),
                _buildDateRange(context),
                if (isActive || daysUntilStart <= 7) ...[
                  const SizedBox(height: 12),
                  _buildStatusBadge(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Iconsax.airplane,
            color: AppTheme.primaryColor,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildDestinations(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: destinations.take(3).map((destination) {
        final index = destinations.indexOf(destination);
        final color = AppTheme.categoryColors[index % AppTheme.categoryColors.length];
        
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Iconsax.location,
                size: 12,
                color: color,
              ),
              const SizedBox(width: 4),
              Text(
                destination,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList()..addAll([
        if (destinations.length > 3)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.textSecondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '+${destinations.length - 3} more',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ]),
    );
  }

  Widget _buildDateRange(BuildContext context) {
    final dateFormat = DateFormat('MMM dd');
    final startDateStr = dateFormat.format(startDate);
    final endDateStr = dateFormat.format(endDate);
    final duration = endDate.difference(startDate).inDays + 1;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Iconsax.calendar_1,
            color: AppTheme.secondaryColor,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            '$startDateStr - $endDateStr',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$duration days',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressAndStats(BuildContext context, double progressPercentage) {
    final numberFormat = NumberFormat.currency(symbol: getCurrencySymbol());
    
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Iconsax.task_square,
                    size: 14,
                    color: AppTheme.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Tasks',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '$completedTasks / $totalTasks',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: progressPercentage,
                backgroundColor: AppTheme.textSecondary.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  progressPercentage < 0.5 
                      ? AppTheme.warning 
                      : progressPercentage < 0.8 
                          ? AppTheme.secondaryColor 
                          : AppTheme.success,
                ),
                borderRadius: BorderRadius.circular(4),
                minHeight: 6,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                const Icon(
                  Iconsax.dollar_circle,
                  size: 14,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Budget',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              numberFormat.format(totalExpense),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.success,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.success.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppTheme.success,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Trip in Progress',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    } else if (daysUntilStart <= 7) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.accentColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Iconsax.clock,
              color: AppTheme.accentColor,
              size: 12,
            ),
            const SizedBox(width: 8),
            Text(
              daysUntilStart == 0 
                  ? 'Starting Today!' 
                  : '$daysUntilStart days to go',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
    
    return const SizedBox.shrink();
  }

  String getCurrencySymbol() {
    switch (currency) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'INR':
        return '₹';
      default:
        return currency;
    }
  }
}