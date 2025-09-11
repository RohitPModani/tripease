import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';
import '../themes/app_theme.dart';
import '../providers/expense_provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/currency_formatter.dart';
import '../utils/snackbar.dart';

class SettlementDetailScreen extends StatefulWidget {
  final String fromUserId;
  final String toUserId;
  final String fromUserName;
  final String toUserName;
  final String tripId;
  final String currency;

  const SettlementDetailScreen({
    super.key,
    required this.fromUserId,
    required this.toUserId,
    required this.fromUserName,
    required this.toUserName,
    required this.tripId,
    required this.currency,
  });

  @override
  State<SettlementDetailScreen> createState() => _SettlementDetailScreenState();
}

class _SettlementDetailScreenState extends State<SettlementDetailScreen> {
  final List<ExpenseSplit> _unpaidSplits = [];
  final List<ExpenseSplit> _paidSplits = [];
  final List<Expense> _relatedExpenses = [];
  double _totalOwed = 0.0;
  double _totalPaid = 0.0;

  @override
  void initState() {
    super.initState();
    _loadSettlementData();
  }

  void _loadSettlementData() {
    final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    
    _relatedExpenses.clear();
    _unpaidSplits.clear();
    _paidSplits.clear();
    _totalOwed = 0.0;
    _totalPaid = 0.0;

    // For simplified settlements, show ALL expenses where the fromUser has splits
    // This gives a complete picture of what the debtor owes across all expenses
    for (final expense in expenseProvider.expenses) {
      bool hasRelatedSplit = false;
      
      for (final split in expense.splits) {
        if (split.userId == widget.fromUserId) {
          // This person has a split in this expense
          if (!hasRelatedSplit) {
            _relatedExpenses.add(expense);
            hasRelatedSplit = true;
          }
          
          if (!split.isPaid) {
            _unpaidSplits.add(split);
            _totalOwed += split.amount;
          } else {
            _paidSplits.add(split);
            _totalPaid += split.amount;
          }
        }
      }
    }

    setState(() {});
  }

  double get _totalAmount => _totalOwed + _totalPaid;
  double get _balanceOwed => _totalOwed;

  Future<void> _settleExpenseSplit(ExpenseSplit split) async {
    try {
      final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
      await expenseProvider.markSplitPaid(split.id);
      
      _loadSettlementData();
      
      if (mounted) {
        showAppSnackBar(
          context,
          'Expense settled successfully',
          type: SnackBarType.success,
        );
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
          context,
          'Failed to settle expense: $e',
          type: SnackBarType.error,
        );
      }
    }
  }

  Future<void> _settleAllExpenses() async {
    try {
      final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
      
      for (final split in _unpaidSplits) {
        await expenseProvider.markSplitPaid(split.id);
      }
      
      _loadSettlementData();
      
      if (mounted) {
        showAppSnackBar(
          context,
          'All expenses settled successfully',
          type: SnackBarType.success,
        );
        
        // Navigate back after settling all
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
          context,
          'Failed to settle all expenses: $e',
          type: SnackBarType.error,
        );
      }
    }
  }

  Future<void> _reopenExpenseSplit(ExpenseSplit split) async {
    try {
      final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
      await expenseProvider.unmarkSplitPaid(split.id);

      _loadSettlementData();

      if (mounted) {
        showAppSnackBar(
          context,
          'Settlement reopened',
          type: SnackBarType.success,
        );
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
          context,
          'Failed to reopen settlement: $e',
          type: SnackBarType.error,
        );
      }
    }
  }

  Future<void> _reopenAllExpenses() async {
    try {
      final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
      for (final split in List<ExpenseSplit>.from(_paidSplits)) {
        await expenseProvider.unmarkSplitPaid(split.id);
      }
      _loadSettlementData();
      if (mounted) {
        showAppSnackBar(
          context,
          'All settlements reopened',
          type: SnackBarType.success,
        );
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
          context,
          'Failed to reopen all settlements: $e',
          type: SnackBarType.error,
        );
      }
    }
  }

  Expense? _getExpenseForSplit(ExpenseSplit split) {
    try {
      return _relatedExpenses.firstWhere((exp) => exp.id == split.expenseId);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppTheme.surfaceDark
          : AppTheme.surfaceLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Settlement Details',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Iconsax.arrow_left),
        ),
      ),
      body: Column(
        children: [
          // Settlement Summary (outer container removed)
          Padding(
            padding: const EdgeInsets.all(16),
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Participants Row
                    Row(
                      children: [
                        // From User
                        Expanded(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.red.withValues(alpha: 0.1),
                                child: Text(
                                  widget.fromUserName[0].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.fromUserName,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Owes',
                                style: TextStyle(
                                  color: Colors.red.shade600,
                                  fontSize: 12,
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
                                size: 24,
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
                        
                        // To User
                        Expanded(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.green.withValues(alpha: 0.1),
                                child: Text(
                                  widget.toUserName[0].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.toUserName,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Receives',
                                style: TextStyle(
                                  color: Colors.green.shade600,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    
                    // Settlement Summary
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryItem(
                            'Total Amount',
                            CurrencyFormatter.formatAmount(_totalAmount, widget.currency),
                            AppTheme.primaryColor,
                          ),
                        ),
                        Expanded(
                          child: _buildSummaryItem(
                            'Paid',
                            CurrencyFormatter.formatAmount(_totalPaid, widget.currency),
                            Colors.green,
                          ),
                        ),
                        Expanded(
                          child: _buildSummaryItem(
                            'Balance',
                            CurrencyFormatter.formatAmount(_balanceOwed, widget.currency),
                            Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Settlement Lists
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_unpaidSplits.isEmpty && _paidSplits.isEmpty)
                    _buildNoExpensesState()
                  else ...[
                    if (_unpaidSplits.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Unpaid Splits',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      ..._unpaidSplits.map((split) {
                        final expense = _getExpenseForSplit(split);
                        return _buildExpenseCard(split, expense);
                      }),
                    ],

                    if (_paidSplits.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Paid Splits',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      ..._paidSplits.map((split) {
                        final expense = _getExpenseForSplit(split);
                        return _buildPaidExpenseCard(split, expense);
                      }),
                    ],
                  ],
                ],
              ),
            ),
          ),
          
          // Bottom actions
          if (_unpaidSplits.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: Container(
                width: double.infinity,
                decoration: AppTheme.glowingButtonDecoration,
                child: ElevatedButton.icon(
                  onPressed: _settleAllExpenses,
                  icon: const Icon(Iconsax.tick_circle, size: 20),
                  label: Text(
                    'Settle All (${CurrencyFormatter.formatAmount(_balanceOwed, widget.currency)})',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
          ),
          if (_unpaidSplits.isEmpty && _paidSplits.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _reopenAllExpenses,
                  icon: const Icon(Iconsax.refresh, size: 18),
                  label: const Text('Reopen All'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryColor,
                    side: BorderSide(color: AppTheme.primaryColor.withValues(alpha: 0.5)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildNoExpensesState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Iconsax.tick_circle,
                size: 48,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'All Settled!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'All expenses between ${widget.fromUserName} and ${widget.toUserName} have been settled.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseCard(ExpenseSplit split, Expense? expense) {
    if (expense == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getCategoryColor(expense.category).withValues(alpha: 0.3),
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
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Category Icon
                Container(
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
                const SizedBox(width: 12),
                
                // Expense Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expense.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getCategoryDisplayName(expense.category),
                        style: TextStyle(
                          color: _getCategoryColor(expense.category),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        _formatDate(expense.date),
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Your Share Amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Your Share',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      CurrencyFormatter.formatAmount(split.amount, widget.currency),
                      style: TextStyle(
                        color: AppTheme.accentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Settle Button
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
              child: ElevatedButton.icon(
                onPressed: () => _settleExpenseSplit(split),
                icon: const Icon(Iconsax.card_send, size: 16),
                label: Text(
                  'Settle ${CurrencyFormatter.formatAmount(split.amount, widget.currency)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaidExpenseCard(ExpenseSplit split, Expense? expense) {
    if (expense == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getCategoryColor(expense.category).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Category Icon
                Container(
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
                const SizedBox(width: 12),
                
                // Expense Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              expense.title,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Paid',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getCategoryDisplayName(expense.category),
                        style: TextStyle(
                          color: _getCategoryColor(expense.category),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        _formatDate(expense.date),
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Your Share Amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Your Share',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      CurrencyFormatter.formatAmount(split.amount, widget.currency),
                      style: TextStyle(
                        color: AppTheme.accentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Reopen Button
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
              child: OutlinedButton.icon(
                onPressed: () => _reopenExpenseSplit(split),
                icon: const Icon(Iconsax.refresh, size: 16),
                label: const Text(
                  'Reopen',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryColor,
                  side: BorderSide(color: AppTheme.primaryColor.withValues(alpha: 0.5)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ),
        ],
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
}
