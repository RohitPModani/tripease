import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/expense.dart';
import '../themes/app_theme.dart';
import '../providers/expense_provider.dart';
import '../utils/form_validators.dart';
import '../l10n/app_localizations.dart';
import '../utils/snackbar.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Character count state
  int titleCharCount = 0;
  int descriptionCharCount = 0;
  int paidByCharCount = 0;
  
  // Validation error state
  String? titleError;
  String? descriptionError;
  String? paidByError;

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
    paidByController = TextEditingController(
      text: widget.expense?.paidBy ?? '',
    );

    selectedCategory = widget.expense?.category ?? ExpenseCategory.other;
    selectedDate = widget.expense?.date ?? DateTime.now();
    
    // Initialize character counts
    titleCharCount = titleController.text.length;
    descriptionCharCount = descriptionController.text.length;
    paidByCharCount = paidByController.text.length;
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
                    TextFormField(
                      controller: titleController,
                      maxLength: FormValidators.titleLimit,
                      onChanged: (value) {
                        setState(() {
                          titleCharCount = value.length;
                          titleError = FormValidators.validateTitle(value, context);
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
                    TextFormField(
                      controller: paidByController,
                      maxLength: FormValidators.paidByLimit,
                      onChanged: (value) {
                        setState(() {
                          paidByCharCount = value.length;
                          paidByError = FormValidators.validatePaidBy(value, context);
                        });
                      },
                      decoration:
                          FormValidators.createOptionalInputDecoration(
                            labelText: AppLocalizations.of(context)!.paidBy,
                            maxLength: FormValidators.paidByLimit,
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
                            suffixText: '$paidByCharCount/${FormValidators.paidByLimit}',
                            suffixStyle: TextStyle(
                              fontSize: 12,
                              color: paidByCharCount > FormValidators.paidByLimit 
                                  ? AppTheme.error 
                                  : AppTheme.textSecondary,
                            ),
                            errorText: paidByError,
                          ),
                      validator: (value) => FormValidators.validatePaidBy(value, context),
                    ),
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
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) return;

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
                                  paidBy: paidByController.text.trim(),
                                  date: selectedDate,
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
                                  showAppSnackBar(
                                    context,
                                    'Failed to ${isEdit ? 'update' : 'add'} expense: $e',
                                    type: SnackBarType.error,
                                  );
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
                              child: Text(
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
}
