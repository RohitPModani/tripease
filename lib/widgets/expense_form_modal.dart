import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/expense.dart';
import '../models/trip_member.dart';
import '../themes/app_theme.dart';
import '../providers/expense_provider.dart';
import '../providers/trip_member_provider.dart';
import '../utils/form_validators.dart';
import '../l10n/app_localizations.dart';
import 'split_selection_modal.dart';
import 'form_error_display.dart';
import '../utils/currency_formatter.dart';

class ExpenseFormModal extends StatefulWidget {
  final String tripId;
  final String defaultCurrency;
  final Expense? expense;

  const ExpenseFormModal({
    super.key,
    required this.tripId,
    required this.defaultCurrency,
    this.expense,
  });

  // Helper to present the modal from anywhere
  static void show(
    BuildContext context,
    String tripId,
    String defaultCurrency, {
    Expense? expense,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ExpenseFormModal(
          tripId: tripId,
          defaultCurrency: defaultCurrency,
          expense: expense,
        ),
      ),
    );
  }

  @override
  State<ExpenseFormModal> createState() => _ExpenseFormModalState();
}

class _ExpenseFormModalState extends State<ExpenseFormModal> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController amountController;
  late final TextEditingController paidByController;

  late ExpenseCategory selectedCategory;
  late DateTime selectedDate;
  String selectedPaidBy = 'You'; // Default to 'You'
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Split functionality
  SplitSelection? currentSplit;
  List<TripMember> availableMembers = [];
  List<String> paidByOptions = ['You']; // Always include 'You' option
  
  // Character count state
  int titleCharCount = 0;
  int descriptionCharCount = 0;
  
  // Validation error state
  String? titleError;
  String? descriptionError;
  
  // Form submission error state
  String? formError;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.expense?.title ?? '');
    descriptionController = TextEditingController(
      text: widget.expense?.description ?? '',
    );
    amountController = TextEditingController(
      text: widget.expense?.amount.toString() ?? '',
    );
    paidByController = TextEditingController();
    selectedPaidBy = widget.expense?.paidBy.isNotEmpty == true ? widget.expense!.paidBy : 'You';

    selectedCategory = widget.expense?.category ?? ExpenseCategory.other;
    selectedDate = widget.expense?.date ?? DateTime.now();
    
    // Initialize character counts
    titleCharCount = titleController.text.length;
    descriptionCharCount = descriptionController.text.length;
    
    // Load trip members and initialize split
    _loadTripMembers();
    _initializeSplit();
  }
  
  void _loadTripMembers() async {
    final memberProvider = Provider.of<TripMemberProvider>(context, listen: false);
    await memberProvider.loadMembers(widget.tripId);
    setState(() {
      availableMembers = memberProvider.members;
      
      // Update paid by options: if no members, show 'You', otherwise show member names only
      if (memberProvider.members.isEmpty) {
        paidByOptions = ['You'];
        selectedPaidBy = 'You';
      } else {
        paidByOptions = memberProvider.members.map((m) => m.name).toList();
        // If selected paidBy is not in options, select first member
        if (!paidByOptions.contains(selectedPaidBy)) {
          selectedPaidBy = paidByOptions.first;
        }
      }
    });
  }
  
  void _initializeSplit() {
    if (widget.expense != null && widget.expense!.splits.isNotEmpty) {
      // Convert existing splits to SplitSelection
      final participants = widget.expense!.splits.map((split) {
        final member = availableMembers.firstWhere(
          (m) => m.id == split.userId,
          orElse: () => TripMember(
            id: split.userId,
            tripId: widget.tripId,
            name: 'Unknown',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
        return member.name;
      }).toList();
      
      final customAmounts = <String, double>{};
      for (final split in widget.expense!.splits) {
        final member = availableMembers.firstWhere(
          (m) => m.id == split.userId,
          orElse: () => TripMember(
            id: split.userId,
            tripId: widget.tripId,
            name: 'Unknown',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
        customAmounts[member.name] = split.amount;
      }
      
      // Determine split type
      final isEqualSplit = widget.expense!.splits.every(
        (split) => (split.amount - (widget.expense!.amount / widget.expense!.splits.length)).abs() < 0.01
      );
      
      currentSplit = SplitSelection(
        type: isEqualSplit ? SplitType.equal : SplitType.custom,
        participants: participants,
        customAmounts: isEqualSplit ? {} : customAmounts,
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    paidByController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.expense != null;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => Container(
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
              color: AppTheme.textSecondary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Iconsax.dollar_circle,
                            color: AppTheme.accentColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          isEdit ? AppLocalizations.of(context)!.editExpense : AppLocalizations.of(context)!.addNewExpense,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    FormErrorDisplay(error: formError),
                    TextFormField(
                      controller: titleController,
                      maxLength: FormValidators.titleLimit,
                      onChanged: (value) {
                        setState(() {
                          titleCharCount = value.length;
                          titleError = FormValidators.validateTitle(value, context);
                          // Clear form error when user starts typing
                          if (formError != null) {
                            formError = null;
                          }
                        });
                      },
                      decoration:
                          FormValidators.createRequiredInputDecoration(
                            labelText: AppLocalizations.of(context)!.expenseTitle,
                            maxLength: FormValidators.titleLimit,
                            context: context,
                          ).copyWith(
                            labelStyle: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppTheme.textSecondary.withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.accentColor,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.error,
                                width: 2,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.error,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            counterText: '',
                            suffixText: '$titleCharCount/${FormValidators.titleLimit}',
                            suffixStyle: TextStyle(
                              fontSize: 12,
                              color: titleCharCount > FormValidators.titleLimit 
                                  ? AppTheme.error 
                                  : AppTheme.textSecondary,
                            ),
                            errorText: titleError,
                          ),
                      validator: (value) => FormValidators.validateTitle(value, context),
                      autofocus: true,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: amountController,
                      onChanged: (value) {
                        setState(() {
                          // Trigger rebuild to update split section availability
                          // Clear form error when user starts typing
                          if (formError != null) {
                            formError = null;
                          }
                        });
                      },
                      decoration: FormValidators.createRequiredInputDecoration(
                        labelText: AppLocalizations.of(context)!.amountCurrency(widget.defaultCurrency),
                        maxLength: 0, // No character limit for amount
                        context: context,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppTheme.textSecondary.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppTheme.accentColor,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        suffixText: null, // Remove character counter for amount field
                      ),
                      validator: (value) => FormValidators.validateAmount(value, context),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<ExpenseCategory>(
                      value: selectedCategory,
                      decoration: FormValidators.createOptionalInputDecoration(
                        labelText: AppLocalizations.of(context)!.category,
                        maxLength: 0, // Not applicable for dropdown
                        context: context,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppTheme.textSecondary.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppTheme.accentColor,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        suffixText: null, // Remove character counter for dropdown
                      ),
                      items: ExpenseCategory.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Row(
                                children: [
                                  Icon(_getCategoryIcon(category), size: 16),
                                  const SizedBox(width: 8),
                                  Text(_getCategoryDisplayName(category)),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      maxLength: FormValidators.descriptionLimit,
                      onChanged: (value) {
                        setState(() {
                          descriptionCharCount = value.length;
                          descriptionError = FormValidators.validateDescription(value, context);
                        });
                      },
                      decoration:
                          FormValidators.createOptionalInputDecoration(
                            labelText: AppLocalizations.of(context)!.description,
                            maxLength: FormValidators.descriptionLimit,
                            context: context,
                          ).copyWith(
                            labelStyle: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppTheme.textSecondary.withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.accentColor,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.error,
                                width: 2,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.error,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            counterText: '',
                            suffixText: '$descriptionCharCount/${FormValidators.descriptionLimit}',
                            suffixStyle: TextStyle(
                              fontSize: 12,
                              color: descriptionCharCount > FormValidators.descriptionLimit 
                                  ? AppTheme.error 
                                  : AppTheme.textSecondary,
                            ),
                            errorText: descriptionError,
                          ),
                      validator: (value) => FormValidators.validateDescription(value, context),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedPaidBy,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.paidBy,
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppTheme.textSecondary.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppTheme.accentColor,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      items: paidByOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Row(
                            children: [
                              if (option == 'You') ...[
                                Icon(Iconsax.user, size: 16, color: AppTheme.primaryColor),
                                const SizedBox(width: 8),
                                Text(option, style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w600)),
                              ] else ...[
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: AppTheme.success.withValues(alpha: 0.1),
                                  child: Text(
                                    option.substring(0, 1).toUpperCase(),
                                    style: TextStyle(
                                      color: AppTheme.success,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(option),
                              ],
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedPaidBy = newValue;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    // Split expense section
                    _buildSplitSection(),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now().subtract(
                            const Duration(days: 365),
                          ),
                          lastDate: DateTime.now().add(
                            const Duration(days: 30),
                          ),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: Theme.of(context).colorScheme
                                    .copyWith(primary: AppTheme.accentColor),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (date != null) {
                          setState(() {
                            selectedDate = date;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.textSecondary.withValues(alpha: 0.3),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.calendar_1,
                              color: AppTheme.accentColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(
                                color: AppTheme.textSecondary.withValues(alpha: 0.3),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.cancel,
                              style: TextStyle(color: AppTheme.textSecondary),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            decoration: AppTheme.glowingButtonDecoration,
                            child: ElevatedButton(
                              onPressed: isSubmitting ? null : () async {
                                if (!_formKey.currentState!.validate()) return;

                                setState(() {
                                  isSubmitting = true;
                                  formError = null;
                                });

                                final expenseItem = Expense(
                                  id: widget.expense?.id ?? const Uuid().v4(),
                                  tripId: widget.tripId,
                                  title: titleController.text.trim(),
                                  amount:
                                      double.tryParse(amountController.text) ??
                                      0.0,
                                  category: selectedCategory,
                                  description: descriptionController.text
                                      .trim(),
                                  paidBy: selectedPaidBy,
                                  date: selectedDate,
                                  splits: _createExpenseSplits(),
                                  createdAt:
                                      widget.expense?.createdAt ??
                                      DateTime.now(),
                                  updatedAt: DateTime.now(),
                                );

                                try {
                                  if (isEdit) {
                                    await Provider.of<ExpenseProvider>(
                                      context,
                                      listen: false,
                                    ).updateExpense(expenseItem);
                                  } else {
                                    await Provider.of<ExpenseProvider>(
                                      context,
                                      listen: false,
                                    ).createExpense(expenseItem);
                                  }
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                } catch (e) {
                                  if (!context.mounted) return;
                                  setState(() {
                                    isSubmitting = false;
                                    formError = 'Failed to ${isEdit ? 'update' : 'add'} expense. Please try again.';
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: isSubmitting 
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : Text(
                                    isEdit ? AppLocalizations.of(context)!.updateExpense : AppLocalizations.of(context)!.addExpense,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
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
        ],
      ),
      ),
    ),
    );
  }

  IconData _getCategoryIcon(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return Iconsax.cup;
      case ExpenseCategory.transport:
        return Iconsax.car;
      case ExpenseCategory.accommodation:
        return Iconsax.home_2;
      case ExpenseCategory.activities:
        return Iconsax.music;
      case ExpenseCategory.shopping:
        return Iconsax.shopping_bag;
      case ExpenseCategory.other:
        return Iconsax.document;
    }
  }

  String _getCategoryDisplayName(ExpenseCategory category) {
    final l10n = AppLocalizations.of(context)!;
    switch (category) {
      case ExpenseCategory.food:
        return l10n.food;
      case ExpenseCategory.transport:
        return l10n.transport;
      case ExpenseCategory.accommodation:
        return l10n.accommodation;
      case ExpenseCategory.activities:
        return l10n.entertainment;
      case ExpenseCategory.shopping:
        return l10n.shopping;
      case ExpenseCategory.other:
        return l10n.other;
    }
  }

  Widget _buildSplitSection() {
    final amount = double.tryParse(amountController.text) ?? 0.0;
    List<String> splitParticipants;
    
    if (availableMembers.isEmpty) {
      // If no members, can't split (need at least 2 people to split)
      return Container(
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
            Icon(
              Iconsax.info_circle,
              color: AppTheme.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              'Add trip members to split expenses',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      // Only include member names for splitting (no 'You' when members exist)
      splitParticipants = availableMembers.map((m) => m.name).toList();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Iconsax.percentage_circle,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Split Expense',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (currentSplit != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      currentSplit!.type == SplitType.equal ? 'Equal' : 'Custom',
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (currentSplit != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _getSplitDescription(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          Padding(
            padding: const EdgeInsets.all(16),
            child: currentSplit != null
                ? Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _showSplitModal(splitParticipants, amount),
                          icon: Icon(
                            Iconsax.edit_2,
                            size: 16,
                          ),
                          label: Text('Edit Split'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(
                              color: AppTheme.primaryColor.withValues(alpha: 0.5),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _removeSplit(),
                          icon: Icon(
                            Iconsax.trash,
                            size: 16,
                            color: AppTheme.error,
                          ),
                          label: Text(
                            'Remove Split',
                            style: TextStyle(color: AppTheme.error),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(
                              color: AppTheme.error.withValues(alpha: 0.5),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showSplitModal(splitParticipants, amount),
                      icon: Icon(
                        Iconsax.add_circle,
                        size: 16,
                      ),
                      label: Text('Add Split'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(
                          color: AppTheme.primaryColor.withValues(alpha: 0.5),
                        ),
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

  String _getSplitDescription() {
    if (currentSplit == null) return '';
    
    if (currentSplit!.type == SplitType.equal) {
      final count = currentSplit!.participants.length;
      final amount = double.tryParse(amountController.text) ?? 0.0;
      final perPerson = count > 0 ? amount / count : 0.0;
      return 'Split equally among $count people (${CurrencyFormatter.getCurrencySymbol(widget.defaultCurrency)}${perPerson.toStringAsFixed(2)} each)';
    } else {
      return 'Custom split among ${currentSplit!.participants.length} people';
    }
  }

  void _showSplitModal(List<String> splitParticipants, double totalAmount) async {
    if (totalAmount <= 0) {
      // Show validation error directly in UI
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Please enter an amount before setting up the split',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final result = await SplitSelectionModal.show(
      context,
      availableMembers: splitParticipants,
      totalAmount: totalAmount,
      currency: widget.defaultCurrency,
      currentSplit: currentSplit,
    );

    if (result != null) {
      setState(() {
        currentSplit = result;
      });
    }
  }

  void _removeSplit() {
    setState(() {
      currentSplit = null;
    });
  }

  List<ExpenseSplit> _createExpenseSplits() {
    if (currentSplit == null) return [];

    final amount = double.tryParse(amountController.text) ?? 0.0;
    final splits = <ExpenseSplit>[];

    for (final participantName in currentSplit!.participants) {
      double splitAmount;
      if (currentSplit!.type == SplitType.equal) {
        splitAmount = amount / currentSplit!.participants.length;
      } else {
        splitAmount = currentSplit!.customAmounts[participantName] ?? 0.0;
      }

      final member = availableMembers.firstWhere(
        (m) => m.name == participantName,
        orElse: () => availableMembers.first,
      );
      String userId = member.id;

      // Automatically mark as paid if this person is the one who paid the expense
      final isPaidForPayer = participantName == selectedPaidBy;

      splits.add(ExpenseSplit(
        id: const Uuid().v4(),
        expenseId: widget.expense?.id ?? const Uuid().v4(),
        userId: userId,
        amount: splitAmount,
        isPaid: isPaidForPayer,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
    }

    return splits;
  }
}
