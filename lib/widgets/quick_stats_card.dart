import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../themes/app_theme.dart';
import '../l10n/app_localizations.dart';

class QuickStatsCard extends StatelessWidget {
  const QuickStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Theme.of(context).brightness == Brightness.dark
          ? AppTheme.pixieCardDecorationDark
          : AppTheme.pixieCardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.chart,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context)!.quickStats,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    icon: Iconsax.map,
                    label: AppLocalizations.of(context)!.activeTrips,
                    value: '3',
                    color: AppTheme.primaryColor,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppTheme.textSecondary.withOpacity(0.2),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    icon: Iconsax.task_square,
                    label: AppLocalizations.of(context)!.pendingTasks,
                    value: '12',
                    color: AppTheme.warning,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppTheme.textSecondary.withOpacity(0.2),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    icon: Iconsax.dollar_circle,
                    label: AppLocalizations.of(context)!.totalBudget,
                    value: '\$7,500',
                    color: AppTheme.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Iconsax.clock,
                    color: AppTheme.accentColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.nextTripStartsIn(5),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.accentColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}