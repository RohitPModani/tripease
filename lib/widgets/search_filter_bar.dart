import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../themes/app_theme.dart';

class SearchFilterBar extends StatelessWidget {
  final String searchQuery;
  final String sortBy;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onSortChanged;

  const SearchFilterBar({
    super.key,
    required this.searchQuery,
    required this.sortBy,
    required this.onSearchChanged,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.surfaceDark
                  : AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: TextField(
              onChanged: onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Search trips...',
                prefixIcon: Icon(Iconsax.search_normal_1),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.surfaceDark
                : AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: PopupMenuButton<String>(
            icon: Container(
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Iconsax.sort,
                color: AppTheme.primaryColor,
              ),
            ),
            onSelected: onSortChanged,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'daysUntilStart',
                child: Row(
                  children: [
                    Icon(Iconsax.clock),
                    SizedBox(width: 12),
                    Text('Days Until Start'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'dateCreated',
                child: Row(
                  children: [
                    Icon(Iconsax.calendar),
                    SizedBox(width: 12),
                    Text('Date Created'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'alphabetical',
                child: Row(
                  children: [
                    Icon(Iconsax.text),
                    SizedBox(width: 12),
                    Text('Alphabetical'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'budget',
                child: Row(
                  children: [
                    Icon(Iconsax.dollar_circle),
                    SizedBox(width: 12),
                    Text('Budget'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}