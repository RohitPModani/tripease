import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/trip.dart';
import '../../models/expense.dart';
import '../../models/trip_member.dart';
import '../../themes/app_theme.dart';
import '../../providers/expense_provider.dart';
import '../../providers/trip_member_provider.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/currency_formatter.dart';
import '../../widgets/expense_form_modal.dart';
import '../../widgets/settlement_action_modal.dart';
import '../../utils/snackbar.dart';
import '../settlement_detail_screen.dart';

class Settlement {
  final String from;
  final String to;
  final double amount;
  final String? fromUserId;
  final String? toUserId;
  final double paidAmount;
  final double balanceAmount;

  Settlement({
    required this.from,
    required this.to,
    required this.amount,
    this.fromUserId,
    this.toUserId,
    this.paidAmount = 0.0,
    this.balanceAmount = 0.0,
  });
}

class ExpensesTab extends StatefulWidget {
  final Trip trip;

  const ExpensesTab({super.key, required this.trip});

  @override
  State<ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends State<ExpensesTab> {
  ExpenseCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseProvider>(context, listen: false).loadExpenses(widget.trip.id);
      Provider.of<TripMemberProvider>(context, listen: false).loadMembers(widget.trip.id);
    });
  }

  List<Expense> _getFilteredExpenses(List<Expense> expenses) {
    if (_selectedCategory == null) {
      return expenses;
    }
    return expenses.where((expense) => expense.category == _selectedCategory).toList();
  }

  List<Expense> _getSortedExpenses(List<Expense> expenses) {
    final filtered = _getFilteredExpenses(expenses);
    filtered.sort((a, b) => b.date.compareTo(a.date));
    return filtered;
  }

  double _getTotalExpenses(List<Expense> expenses) {
    return _getFilteredExpenses(expenses).fold(0, (sum, expense) => sum + expense.amount);
  }

  Map<String, double> _getExpensesByPerson(List<Expense> expenses) {
    // Compute actual cost per person (their share), not amount paid
    final Map<String, double> personTotals = {};
    final filtered = _getFilteredExpenses(expenses);
    final memberProvider = Provider.of<TripMemberProvider>(context, listen: false);

    String _nameForUserId(String userId) {
      try {
        final m = memberProvider.members.firstWhere((e) => e.id == userId);
        return m.name;
      } catch (_) {
        return 'Unknown';
      }
    }

    for (final expense in filtered) {
      if (expense.splits.isNotEmpty) {
        // Distribute according to splits
        for (final split in expense.splits) {
          final name = _nameForUserId(split.userId);
          personTotals[name] = (personTotals[name] ?? 0) + split.amount;
        }
      } else {
        // No splits provided: attribute full cost to payer if known, else Unknown
        final name = expense.paidBy.isNotEmpty
            ? expense.paidBy
            : AppLocalizations.of(context)!.you;
        personTotals[name] = (personTotals[name] ?? 0) + expense.amount;
      }
    }

    return personTotals;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, expenseProvider, child) {
        if (expenseProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          );
        }

        if (expenseProvider.error != null) {
          return Center(
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
                  AppLocalizations.of(context)!.failedToLoad,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  expenseProvider.error!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => expenseProvider.loadExpenses(widget.trip.id),
                  child: Text(AppLocalizations.of(context)!.retry),
                ),
              ],
            ),
          );
        }

        final expenses = expenseProvider.expenses;
        final sortedExpenses = _getSortedExpenses(expenses);

        return Scaffold(
          body: Column(
            children: [
              _buildSummaryCard(expenses),
              if (expenses.isNotEmpty) ...[
                _buildFilterChips(expenses),
              ],
              Expanded(
                child: expenses.isEmpty
                    ? _buildEmptyState(expenseProvider)
                    : sortedExpenses.isEmpty && _selectedCategory != null
                        ? _buildNoResultsState()
                        : RefreshIndicator(
                            onRefresh: () => expenseProvider.loadExpenses(widget.trip.id),
                            color: AppTheme.primaryColor,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: sortedExpenses.length,
                              itemBuilder: (context, index) {
                                return _buildExpenseItem(sortedExpenses[index], expenseProvider);
                              },
                            ),
                          ),
              ),
            ],
          ),
          floatingActionButton: Container(
            decoration: AppTheme.glowingButtonDecoration,
            child: FloatingActionButton.extended(
              onPressed: () => ExpenseFormModal.show(context, widget.trip.id, widget.trip.defaultCurrency),
              icon: const Icon(Iconsax.add),
              label: Text(
                AppLocalizations.of(context)!.addExpense,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(List<Expense> expenses) {
    final categoryTotals = <ExpenseCategory, double>{};
    for (final expense in expenses) {
      categoryTotals[expense.category] = 
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkCardGradient
            : AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color: Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            gradient: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.darkCardGradient
                : AppTheme.cardGradient,
            borderRadius: BorderRadius.circular(14),
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
                    color: AppTheme.accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.dollar_circle,
                    color: AppTheme.accentColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.totalExpenses,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        CurrencyFormatter.formatAmount(_getTotalExpenses(expenses), widget.trip.defaultCurrency),
                        style: const TextStyle(
                          color: AppTheme.accentColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _showExpenseBreakdown(expenses),
                    icon: const Icon(Iconsax.chart_21, size: 18),
                    label: Text(AppLocalizations.of(context)!.breakdown),
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.08),
                      foregroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _showSettlementSummary(expenses),
                    icon: const Icon(Iconsax.wallet_money, size: 18),
                    label: const Text('Settlements'),
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.accentColor.withValues(alpha: 0.08),
                      foregroundColor: AppTheme.accentColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    ),
    );
  }

  Widget _buildEmptyState(ExpenseProvider expenseProvider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Iconsax.dollar_circle,
                size: 48,
                color: AppTheme.accentColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.noExpensesYet,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track your trip expenses and split costs with travel companions!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: AppTheme.glowingButtonDecoration,
              child: ElevatedButton.icon(
                onPressed: () => ExpenseFormModal.show(context, widget.trip.id, widget.trip.defaultCurrency),
                icon: const Icon(Iconsax.add),
                label: Text(
                  AppLocalizations.of(context)!.addExpense,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseItem(Expense expense, ExpenseProvider expenseProvider) {
    return Dismissible(
      key: Key(expense.id),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Delete action
          return await _showDeleteConfirmation(expense, expenseProvider);
        } else if (direction == DismissDirection.startToEnd) {
          // Edit action - don't dismiss, just open edit dialog
          ExpenseFormModal.show(context, widget.trip.id, widget.trip.defaultCurrency, expense: expense);
          return false;
        }
        return false;
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.edit_2,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.edit,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.delete,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Iconsax.trash,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getCategoryColor(expense.category).withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          onTap: () => _showExpenseDetailsBottomSheet(expense, expenseProvider),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getCategoryColor(expense.category).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getCategoryIcon(expense.category),
              color: _getCategoryColor(expense.category),
              size: 20,
            ),
          ),
          title: Text(
            expense.title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(expense.category).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _getCategoryColor(expense.category).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    _getCategoryDisplayName(expense.category),
                    style: TextStyle(
                      color: _getCategoryColor(expense.category),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (expense.paidBy.isNotEmpty || expense.splits.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (expense.paidBy.isNotEmpty) ...[
                        Icon(
                          Iconsax.user,
                          size: 14,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.textSecondaryDark
                              : AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${AppLocalizations.of(context)!.paidBy}: ${expense.paidBy}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.textSecondaryDark
                              : AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                CurrencyFormatter.formatAmount(expense.amount, widget.trip.defaultCurrency),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppTheme.accentColor,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 12,
                    color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(expense.date),
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final l10n = AppLocalizations.of(context)!;
    final months = [
      l10n.january,
      l10n.february,
      l10n.march,
      l10n.april,
      l10n.may,
      l10n.june,
      l10n.july,
      l10n.august,
      l10n.september,
      l10n.october,
      l10n.november,
      l10n.december,
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _showExpenseDetailsBottomSheet(Expense expense, ExpenseProvider expenseProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: (Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(expense.category).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getCategoryIcon(expense.category),
                            color: _getCategoryColor(expense.category),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.expenseDetails,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _getCategoryDisplayName(expense.category),
                                style: TextStyle(
                                  color: _getCategoryColor(expense.category),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      expense.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.amount,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                CurrencyFormatter.formatAmount(expense.amount, widget.trip.defaultCurrency),
                                style: const TextStyle(
                                  color: AppTheme.accentColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.date,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.calendar_1,
                                    size: 16,
                                    color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.textSecondaryDark
                              : AppTheme.textSecondary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    _formatDate(expense.date),
                                    style: TextStyle(
                                      color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.textSecondaryDark
                              : AppTheme.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (expense.description.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.description,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        expense.description,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.textSecondaryDark
                              : AppTheme.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                    if (expense.paidBy.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.paidBy,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Iconsax.user,
                            size: 16,
                            color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.textSecondaryDark
                              : AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            expense.paidBy,
                            style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.textSecondaryDark
                              : AppTheme.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (expense.splits.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _buildSplitDetails(expense),
                    ],
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              ExpenseFormModal.show(context, widget.trip.id, widget.trip.defaultCurrency, expense: expense);
                            },
                            icon: const Icon(Iconsax.edit_2),
                            label: Text(AppLocalizations.of(context)!.edit),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.accentColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              Navigator.pop(context);
                              await expenseProvider.deleteExpense(expense.id);
                            },
                            icon: const Icon(Iconsax.trash),
                            label: Text(AppLocalizations.of(context)!.delete),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.error,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.transport:
        return Colors.blue;
      case ExpenseCategory.accommodation:
        return Colors.purple;
      case ExpenseCategory.food:
        return Colors.orange;
      case ExpenseCategory.activities:
        return Colors.green;
      case ExpenseCategory.shopping:
        return Colors.pink;
      case ExpenseCategory.other:
        return Theme.of(context).brightness == Brightness.dark
            ? AppTheme.textSecondaryDark
            : AppTheme.textSecondary;
    }
  }

  IconData _getCategoryIcon(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.transport:
        return Iconsax.car;
      case ExpenseCategory.accommodation:
        return Iconsax.building_4;
      case ExpenseCategory.food:
        return Iconsax.cup;
      case ExpenseCategory.activities:
        return Iconsax.camera;
      case ExpenseCategory.shopping:
        return Iconsax.bag_2;
      case ExpenseCategory.other:
        return Iconsax.dollar_circle;
    }
  }

  String _getCategoryDisplayName(ExpenseCategory category) {
    final l10n = AppLocalizations.of(context)!;
    switch (category) {
      case ExpenseCategory.transport:
        return l10n.transport;
      case ExpenseCategory.accommodation:
        return l10n.accommodation;
      case ExpenseCategory.food:
        return l10n.food;
      case ExpenseCategory.activities:
        return l10n.activities;
      case ExpenseCategory.shopping:
        return l10n.shopping;
      case ExpenseCategory.other:
        return l10n.other;
    }
  }


  Future<bool> _showDeleteConfirmation(Expense expense, ExpenseProvider expenseProvider) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Iconsax.warning_2,
                  color: AppTheme.error,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(AppLocalizations.of(context)!.deleteExpense),
            ],
          ),
          content: Text(
            AppLocalizations.of(context)!.deleteTaskConfirmation(expense.title),
            style: const TextStyle(height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                await expenseProvider.deleteExpense(expense.id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.error,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.delete),
            ),
          ],
        );
      },
    ) ?? false;
  }


  Widget _buildFilterChips(List<Expense> expenses) {
    final transportCount = expenses.where((expense) => expense.category == ExpenseCategory.transport).length;
    final accommodationCount = expenses.where((expense) => expense.category == ExpenseCategory.accommodation).length;
    final foodCount = expenses.where((expense) => expense.category == ExpenseCategory.food).length;
    final activitiesCount = expenses.where((expense) => expense.category == ExpenseCategory.activities).length;
    final shoppingCount = expenses.where((expense) => expense.category == ExpenseCategory.shopping).length;
    final otherCount = expenses.where((expense) => expense.category == ExpenseCategory.other).length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 40,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              FilterChip(
                label: Text(AppLocalizations.of(context)!.allWithCount(expenses.length)),
                selected: _selectedCategory == null,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = null;
                  });
                },
                selectedColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                checkmarkColor: AppTheme.primaryColor,
                labelStyle: TextStyle(
                  color: _selectedCategory == null ? AppTheme.primaryColor : null,
                  fontWeight: _selectedCategory == null ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text('${AppLocalizations.of(context)!.transport} ($transportCount)'),
                selected: _selectedCategory == ExpenseCategory.transport,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = selected ? ExpenseCategory.transport : null;
                  });
                },
                selectedColor: _getCategoryColor(ExpenseCategory.transport).withValues(alpha: 0.2),
                checkmarkColor: _getCategoryColor(ExpenseCategory.transport),
                labelStyle: TextStyle(
                  color: _selectedCategory == ExpenseCategory.transport ? _getCategoryColor(ExpenseCategory.transport) : null,
                  fontWeight: _selectedCategory == ExpenseCategory.transport ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text('${AppLocalizations.of(context)!.accommodation} ($accommodationCount)'),
                selected: _selectedCategory == ExpenseCategory.accommodation,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = selected ? ExpenseCategory.accommodation : null;
                  });
                },
                selectedColor: _getCategoryColor(ExpenseCategory.accommodation).withValues(alpha: 0.2),
                checkmarkColor: _getCategoryColor(ExpenseCategory.accommodation),
                labelStyle: TextStyle(
                  color: _selectedCategory == ExpenseCategory.accommodation ? _getCategoryColor(ExpenseCategory.accommodation) : null,
                  fontWeight: _selectedCategory == ExpenseCategory.accommodation ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text('${AppLocalizations.of(context)!.food} ($foodCount)'),
                selected: _selectedCategory == ExpenseCategory.food,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = selected ? ExpenseCategory.food : null;
                  });
                },
                selectedColor: _getCategoryColor(ExpenseCategory.food).withValues(alpha: 0.2),
                checkmarkColor: _getCategoryColor(ExpenseCategory.food),
                labelStyle: TextStyle(
                  color: _selectedCategory == ExpenseCategory.food ? _getCategoryColor(ExpenseCategory.food) : null,
                  fontWeight: _selectedCategory == ExpenseCategory.food ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text('${AppLocalizations.of(context)!.activities} ($activitiesCount)'),
                selected: _selectedCategory == ExpenseCategory.activities,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = selected ? ExpenseCategory.activities : null;
                  });
                },
                selectedColor: _getCategoryColor(ExpenseCategory.activities).withValues(alpha: 0.2),
                checkmarkColor: _getCategoryColor(ExpenseCategory.activities),
                labelStyle: TextStyle(
                  color: _selectedCategory == ExpenseCategory.activities ? _getCategoryColor(ExpenseCategory.activities) : null,
                  fontWeight: _selectedCategory == ExpenseCategory.activities ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text('${AppLocalizations.of(context)!.shopping} ($shoppingCount)'),
                selected: _selectedCategory == ExpenseCategory.shopping,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = selected ? ExpenseCategory.shopping : null;
                  });
                },
                selectedColor: _getCategoryColor(ExpenseCategory.shopping).withValues(alpha: 0.2),
                checkmarkColor: _getCategoryColor(ExpenseCategory.shopping),
                labelStyle: TextStyle(
                  color: _selectedCategory == ExpenseCategory.shopping ? _getCategoryColor(ExpenseCategory.shopping) : null,
                  fontWeight: _selectedCategory == ExpenseCategory.shopping ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text('${AppLocalizations.of(context)!.other} ($otherCount)'),
                selected: _selectedCategory == ExpenseCategory.other,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = selected ? ExpenseCategory.other : null;
                  });
                },
                selectedColor: _getCategoryColor(ExpenseCategory.other).withValues(alpha: 0.2),
                checkmarkColor: _getCategoryColor(ExpenseCategory.other),
                labelStyle: TextStyle(
                  color: _selectedCategory == ExpenseCategory.other ? _getCategoryColor(ExpenseCategory.other) : null,
                  fontWeight: _selectedCategory == ExpenseCategory.other ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.filter_search,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.noExpensesFound,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'No expenses found for this category',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _selectedCategory = null;
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
    );
  }

  void _showExpenseBreakdown(List<Expense> expenses) {
    final personTotals = _getExpensesByPerson(expenses);
    final categoryTotals = <ExpenseCategory, double>{};
    final totalExp = _getTotalExpenses(expenses);
    
    // Calculate category totals
    for (final expense in expenses) {
      categoryTotals[expense.category] = 
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: (Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Iconsax.chart_21,
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
                          AppLocalizations.of(context)!.expenseBreakdown,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Total: ${CurrencyFormatter.formatAmount(_getTotalExpenses(expenses), widget.trip.defaultCurrency)}',
                          style: TextStyle(
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Iconsax.close_circle),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Breakdown Section with Pie Chart
                    if (categoryTotals.isNotEmpty) ...[
                      Text(
                        'Expenses by Category',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Pie Chart (outer container removed)
                      SizedBox(
                        height: 240,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              PieChart(
                                PieChartData(
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 68,
                                  sections: _buildPieChartSections(categoryTotals),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    CurrencyFormatter.formatAmount(totalExp, widget.trip.defaultCurrency),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.accentColor,
                                        ) ?? const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: AppTheme.accentColor,
                                        ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    AppLocalizations.of(context)!.totalExpenses,
                                    style: TextStyle(
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? AppTheme.textSecondaryDark
                                          : AppTheme.textSecondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Category Legend with progress
                      ...categoryTotals.entries.map((entry) {
                        final totalExp = _getTotalExpenses(expenses);
                        final percentage = totalExp > 0 ? (entry.value / totalExp) : 0.0;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _getCategoryColor(entry.key).withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: _getCategoryColor(entry.key).withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      _getCategoryIcon(entry.key),
                                      color: _getCategoryColor(entry.key),
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      _getCategoryDisplayName(entry.key),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        CurrencyFormatter.formatAmount(entry.value, widget.trip.defaultCurrency),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${(percentage * 100).toInt()}%',
                                        style: TextStyle(
                                          color: _getCategoryColor(entry.key),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              _buildProgressBar(percentage, _getCategoryColor(entry.key)),
                            ],
                          ),
                        );
                      }),
                    ],
                    
                    // Person Breakdown Section  
                    if (personTotals.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text(
                        'Expense per Person',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...personTotals.entries.map((entry) {
                        final totalAll = personTotals.values.fold(0.0, (sum, v) => sum + v);
                        final percentage = totalAll > 0 ? (entry.value / totalAll) : 0.0;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                                    child: Text(
                                      entry.key[0].toUpperCase(),
                                      style: const TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          entry.key,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${(percentage * 100).toInt()}% of total',
                                          style: TextStyle(
                                            color: Theme.of(context).brightness == Brightness.dark
                                                ? AppTheme.textSecondaryDark
                                                : AppTheme.textSecondary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    CurrencyFormatter.formatAmount(entry.value, widget.trip.defaultCurrency),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppTheme.accentColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              _buildProgressBar(percentage, AppTheme.primaryColor),
                            ],
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(double fraction, Color color) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: LinearProgressIndicator(
        value: fraction.clamp(0.0, 1.0),
        minHeight: 8,
        backgroundColor: color.withValues(alpha: 0.12),
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }

  void _showSettlementSummary(List<Expense> expenses) {
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.surfaceDark
              : AppTheme.surfaceLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Consumer<ExpenseProvider>(builder: (context, expenseProvider, _) {
          final settlements = _calculateSettlements(expenseProvider.expenses);
          return Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: (Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Iconsax.arrow_swap_horizontal,
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
                          'Settlement Summary',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          settlements.isEmpty ? 'All settled' : '${settlements.length} transactions needed',
                          style: TextStyle(
                            color: settlements.isEmpty ? Colors.green : AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Iconsax.close_circle),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (settlements.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Iconsax.tick_circle,
                                color: Colors.green,
                                size: 48,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'All Expenses Settled!',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Everyone is even. No money needs to be exchanged.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    else ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.primaryColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.info_circle,
                              color: AppTheme.primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Suggested settlements to balance all expenses',
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...settlements.map((settlement) => GestureDetector(
                        onTap: () => _navigateToSettlementDetail(settlement),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                offset: const Offset(0, 2),
                                blurRadius: 8,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        // Debtor (from)
                                        Expanded(
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 24,
                                                backgroundColor: Colors.red.withValues(alpha: 0.1),
                                                child: Text(
                                                  settlement.from.substring(0, 1).toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                settlement.from,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                'Owes',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.red.shade600,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        
                                        // Arrow
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Iconsax.arrow_right_3,
                                                color: AppTheme.textSecondary,
                                                size: 20,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'pays to',
                                                style: TextStyle(
                                                  color: AppTheme.textSecondary,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        
                                        // Creditor (to)
                                        Expanded(
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 24,
                                                backgroundColor: Colors.green.withValues(alpha: 0.1),
                                                child: Text(
                                                  settlement.to.substring(0, 1).toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                settlement.to,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                'Receives',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.green.shade600,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    const SizedBox(height: 20),
                                    
                                    // Settlement Summary
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).brightness == Brightness.dark
                                            ? AppTheme.textSecondaryDark.withValues(alpha: 0.1)
                                            : AppTheme.textSecondary.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Total',
                                                  style: TextStyle(
                                                    color: AppTheme.textSecondary,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  CurrencyFormatter.formatAmount(settlement.amount, widget.trip.defaultCurrency),
                                                  style: TextStyle(
                                                    color: AppTheme.primaryColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Paid',
                                                  style: TextStyle(
                                                    color: AppTheme.textSecondary,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  CurrencyFormatter.formatAmount(settlement.paidAmount, widget.trip.defaultCurrency),
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Balance',
                                                  style: TextStyle(
                                                    color: AppTheme.textSecondary,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  CurrencyFormatter.formatAmount(settlement.balanceAmount, widget.trip.defaultCurrency),
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Tap to view details hint
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Iconsax.eye,
                                        size: 16,
                                        color: AppTheme.primaryColor,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Tap to view & settle individual expenses',
                                        style: TextStyle(
                                          color: AppTheme.primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
        }),
      ),
    );
  }

  void _navigateToSettlementDetail(Settlement settlement) {
    if (settlement.fromUserId == null || settlement.toUserId == null) {
      showAppSnackBar(
        context,
        'Unable to view settlement details: Member information missing',
        type: SnackBarType.error,
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettlementDetailScreen(
          fromUserId: settlement.fromUserId!,
          toUserId: settlement.toUserId!,
          fromUserName: settlement.from,
          toUserName: settlement.to,
          tripId: widget.trip.id,
          currency: widget.trip.defaultCurrency,
        ),
      ),
    );
  }

  Future<void> _showSettlementAction(Settlement settlement) async {
    if (settlement.fromUserId == null || settlement.toUserId == null) {
      showAppSnackBar(
        context,
        'Unable to process settlement: Member information missing',
        type: SnackBarType.error,
      );
      return;
    }

    final action = await SettlementActionModal.show(
      context,
      fromPerson: settlement.from,
      toPerson: settlement.to,
      totalAmount: settlement.amount,
      currency: widget.trip.defaultCurrency,
    );

    if (action != null) {
      try {
        if (!mounted) return;
        final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
        
        await expenseProvider.recordSettlement(
          fromUserId: settlement.fromUserId!,
          toUserId: settlement.toUserId!,
          amount: action.amount,
          tripId: widget.trip.id,
          note: action.note,
        );

        if (mounted) {
          Navigator.of(context).pop(); // Close settlement modal
          
          String message;
          if (action.type == SettlementActionType.fullPayment) {
            message = '${settlement.from} paid ${CurrencyFormatter.formatAmount(action.amount, widget.trip.defaultCurrency)} to ${settlement.to}';
          } else {
            message = '${settlement.from} paid ${CurrencyFormatter.formatAmount(action.amount, widget.trip.defaultCurrency)} to ${settlement.to} (partial payment)';
          }
          
          showAppSnackBar(
            context,
            message,
            type: SnackBarType.success,
          );
        }
      } catch (e) {
        if (mounted) {
          showAppSnackBar(
            context,
            'Failed to record settlement: $e',
            type: SnackBarType.error,
          );
        }
      }
    }
  }

  List<Settlement> _calculateSettlements(List<Expense> expenses) {
    final Map<String, double> balances = {};
    final Map<String, String> nameToIdMap = {}; // Map names to member IDs
    final Map<String, Map<String, double>> paidAmounts = {}; // Track paid amounts between users
    final Map<String, Map<String, double>> totalAmounts = {}; // Track total amounts between users
    
    final memberProvider = Provider.of<TripMemberProvider>(context, listen: false);
    
    // Initialize tracking maps
    for (final member in memberProvider.members) {
      nameToIdMap[member.name] = member.id;
      paidAmounts[member.name] = {};
      totalAmounts[member.name] = {};
    }
    
    // Calculate net balances and track payment details for each person
    for (final expense in expenses) {
      if (expense.splits.isEmpty) continue;
      
      // Person who paid gets credited
      if (expense.paidBy.isNotEmpty) {
        balances[expense.paidBy] = (balances[expense.paidBy] ?? 0.0) + expense.amount;
      }
      
      // Each person in split gets debited their share
      for (final split in expense.splits) {
        TripMember? member;
        try {
          member = memberProvider.members.firstWhere(
            (m) => m.id == split.userId,
          );
        } catch (e) {
          member = null;
        }
        if (member != null && expense.paidBy.isNotEmpty) {
          balances[member.name] = (balances[member.name] ?? 0.0) - split.amount;
          nameToIdMap[member.name] = member.id;
          
          // Track total amounts between users
          totalAmounts[member.name] ??= {};
          totalAmounts[member.name]![expense.paidBy] = 
              (totalAmounts[member.name]![expense.paidBy] ?? 0.0) + split.amount;
          
          // Track paid amounts
          if (split.isPaid) {
            paidAmounts[member.name] ??= {};
            paidAmounts[member.name]![expense.paidBy] = 
                (paidAmounts[member.name]![expense.paidBy] ?? 0.0) + split.amount;
          }
        }
      }
    }
    
    // Generate settlements using a simplified debt algorithm
    final List<Settlement> settlements = [];
    final List<MapEntry<String, double>> creditors = [];
    final List<MapEntry<String, double>> debtors = [];
    
    for (final entry in balances.entries) {
      if (entry.value > 0.01) { // They are owed money
        creditors.add(entry);
      } else if (entry.value < -0.01) { // They owe money
        debtors.add(MapEntry(entry.key, -entry.value)); // Make positive
      }
    }
    
    // Sort by amount (largest debts/credits first)
    creditors.sort((a, b) => b.value.compareTo(a.value));
    debtors.sort((a, b) => b.value.compareTo(a.value));
    
    int i = 0, j = 0;
    while (i < creditors.length && j < debtors.length) {
      final creditor = creditors[i];
      final debtor = debtors[j];
      
      final settleAmount = [creditor.value, debtor.value].reduce((a, b) => a < b ? a : b);
      
      if (settleAmount > 0.01) {
        // Calculate total amount owed and paid between these two users
        final totalOwed = totalAmounts[debtor.key]?[creditor.key] ?? 0.0;
        final alreadyPaid = paidAmounts[debtor.key]?[creditor.key] ?? 0.0;
        final remainingBalance = totalOwed - alreadyPaid;
        
        settlements.add(Settlement(
          from: debtor.key,
          to: creditor.key,
          amount: totalOwed, // Total amount originally owed
          fromUserId: nameToIdMap[debtor.key],
          toUserId: nameToIdMap[creditor.key],
          paidAmount: alreadyPaid,
          balanceAmount: remainingBalance,
        ));
      }
      
      creditors[i] = MapEntry(creditor.key, creditor.value - settleAmount);
      debtors[j] = MapEntry(debtor.key, debtor.value - settleAmount);
      
      if (creditors[i].value <= 0.01) i++;
      if (debtors[j].value <= 0.01) j++;
    }
    
    return settlements;
  }


  List<PieChartSectionData> _buildPieChartSections(Map<ExpenseCategory, double> categoryTotals) {
    final total = categoryTotals.values.fold(0.0, (sum, value) => sum + value);
    
    return categoryTotals.entries.map((entry) {
      final percentage = total > 0 ? (entry.value / total) : 0.0;
      return PieChartSectionData(
        color: _getCategoryColor(entry.key),
        value: entry.value,
        title: '${(percentage * 100).toInt()}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildSplitDetails(Expense expense) {
    return Consumer<TripMemberProvider>(
      builder: (context, memberProvider, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.percentage_circle,
                    color: AppTheme.primaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Split Details',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  if (expense.isSettled)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Settled',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              ...expense.splits.map((split) {
                TripMember? member;
                try {
                  member = memberProvider.members.firstWhere(
                    (m) => m.id == split.userId,
                  );
                } catch (e) {
                  member = null;
                }
                
                final displayName = member != null ? member.name : 'Unknown Member';
                final avatarLetter = member != null ? member.name.substring(0, 1).toUpperCase() : '?';
                const avatarColor = AppTheme.success;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: avatarColor.withValues(alpha: 0.1),
                        child: Text(
                          avatarLetter,
                          style: const TextStyle(
                            color: avatarColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          displayName,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Text(
                        CurrencyFormatter.formatAmount(split.amount, widget.trip.defaultCurrency),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: split.isPaid ? Colors.green : AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        split.isPaid ? Iconsax.tick_circle : Iconsax.clock,
                        size: 16,
                        color: split.isPaid ? Colors.green : Colors.orange,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
