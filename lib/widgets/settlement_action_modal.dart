import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../themes/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../utils/currency_formatter.dart';
import '../utils/form_validators.dart';

enum SettlementActionType { fullPayment, partialPayment }

class SettlementAction {
  final SettlementActionType type;
  final double amount;
  final String note;

  SettlementAction({
    required this.type,
    required this.amount,
    this.note = '',
  });
}

class SettlementActionModal extends StatefulWidget {
  final String fromPerson;
  final String toPerson;
  final double totalAmount;
  final String currency;

  const SettlementActionModal({
    super.key,
    required this.fromPerson,
    required this.toPerson,
    required this.totalAmount,
    required this.currency,
  });

  static Future<SettlementAction?> show(
    BuildContext context, {
    required String fromPerson,
    required String toPerson,
    required double totalAmount,
    required String currency,
  }) {
    return showModalBottomSheet<SettlementAction>(
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
        child: SettlementActionModal(
          fromPerson: fromPerson,
          toPerson: toPerson,
          totalAmount: totalAmount,
          currency: currency,
        ),
      ),
    );
  }

  @override
  State<SettlementActionModal> createState() => _SettlementActionModalState();
}

class _SettlementActionModalState extends State<SettlementActionModal> {
  late SettlementActionType selectedType;
  late final TextEditingController amountController;
  late final TextEditingController noteController;
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedType = SettlementActionType.fullPayment;
    amountController = TextEditingController(
      text: widget.totalAmount.toStringAsFixed(2),
    );
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _onTypeChanged(SettlementActionType type) {
    setState(() {
      selectedType = type;
      if (type == SettlementActionType.fullPayment) {
        amountController.text = widget.totalAmount.toStringAsFixed(2);
      } else {
        amountController.clear();
      }
    });
  }

  bool get _canSubmit {
    if (selectedType == SettlementActionType.fullPayment) {
      return true;
    }
    
    final amount = double.tryParse(amountController.text) ?? 0.0;
    return amount > 0 && amount <= widget.totalAmount;
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate() || !_canSubmit) return;

    final amount = selectedType == SettlementActionType.fullPayment
        ? widget.totalAmount
        : double.tryParse(amountController.text) ?? 0.0;

    final action = SettlementAction(
      type: selectedType,
      amount: amount,
      note: noteController.text.trim(),
    );

    Navigator.of(context).pop(action);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
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
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Iconsax.card_send,
                        color: Colors.green,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Record Payment',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${widget.fromPerson} → ${widget.toPerson}',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
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
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Settlement Info
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Outstanding Amount',
                                      style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      CurrencyFormatter.formatAmount(widget.totalAmount, widget.currency),
                                      style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Payment Type Selection
                        Text(
                          'Payment Type',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Full Payment Option
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedType == SettlementActionType.fullPayment
                                  ? Colors.green
                                  : Theme.of(context).dividerColor.withValues(alpha: 0.3),
                              width: selectedType == SettlementActionType.fullPayment ? 2 : 1,
                            ),
                            color: selectedType == SettlementActionType.fullPayment
                                ? Colors.green.withValues(alpha: 0.1)
                                : Theme.of(context).colorScheme.surface,
                          ),
                          child: RadioListTile<SettlementActionType>(
                            value: SettlementActionType.fullPayment,
                            groupValue: selectedType,
                            onChanged: (value) => _onTypeChanged(value!),
                            activeColor: Colors.green,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            title: Row(
                              children: [
                                Icon(
                                  Iconsax.tick_circle,
                                  color: selectedType == SettlementActionType.fullPayment
                                      ? Colors.green
                                      : AppTheme.textSecondary,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Full Payment',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: selectedType == SettlementActionType.fullPayment
                                              ? Colors.green
                                              : null,
                                        ),
                                      ),
                                      Text(
                                        CurrencyFormatter.formatAmount(widget.totalAmount, widget.currency),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: selectedType == SettlementActionType.fullPayment
                                              ? Colors.green.shade700
                                              : AppTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Partial Payment Option
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedType == SettlementActionType.partialPayment
                                  ? AppTheme.accentColor
                                  : Theme.of(context).dividerColor.withValues(alpha: 0.3),
                              width: selectedType == SettlementActionType.partialPayment ? 2 : 1,
                            ),
                            color: selectedType == SettlementActionType.partialPayment
                                ? AppTheme.accentColor.withValues(alpha: 0.1)
                                : Theme.of(context).colorScheme.surface,
                          ),
                          child: RadioListTile<SettlementActionType>(
                            value: SettlementActionType.partialPayment,
                            groupValue: selectedType,
                            onChanged: (value) => _onTypeChanged(value!),
                            activeColor: AppTheme.accentColor,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            title: Row(
                              children: [
                                Icon(
                                  Iconsax.card_pos,
                                  color: selectedType == SettlementActionType.partialPayment
                                      ? AppTheme.accentColor
                                      : AppTheme.textSecondary,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Partial Payment',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: selectedType == SettlementActionType.partialPayment
                                              ? AppTheme.accentColor
                                              : null,
                                        ),
                                      ),
                                      Text(
                                        'Enter custom amount',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: selectedType == SettlementActionType.partialPayment
                                              ? AppTheme.accentColor
                                              : AppTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Custom Amount Field (for partial payments)
                        if (selectedType == SettlementActionType.partialPayment) ...[
                          const SizedBox(height: 20),
                          Text(
                            'Payment Amount',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: amountController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              hintText: '0.00',
                              prefixText: '${widget.currency} ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
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
                            validator: (value) {
                              if (selectedType == SettlementActionType.partialPayment) {
                                return FormValidators.validateAmount(value, context);
                              }
                              return null;
                            },
                            onChanged: (value) => setState(() {}),
                          ),
                          
                          if (amountController.text.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Remaining: ${CurrencyFormatter.formatAmount(widget.totalAmount - (double.tryParse(amountController.text) ?? 0.0), widget.currency)}',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                        
                        const SizedBox(height: 20),
                        
                        // Note Field
                        Text(
                          'Note (Optional)',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: noteController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Add a note about this payment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.primaryColor,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Action buttons
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(AppLocalizations.of(context)!.cancel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        decoration: AppTheme.glowingButtonDecoration,
                        child: ElevatedButton(
                          onPressed: _canSubmit ? _handleSubmit : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Record Payment',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}