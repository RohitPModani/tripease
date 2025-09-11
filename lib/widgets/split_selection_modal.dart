import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../themes/app_theme.dart';
import '../l10n/app_localizations.dart';

enum SplitType { equal, custom }

class SplitSelection {
  final SplitType type;
  final List<String> participants;
  final Map<String, double> customAmounts;

  SplitSelection({
    required this.type,
    required this.participants,
    this.customAmounts = const {},
  });
}

class SplitSelectionModal extends StatefulWidget {
  final List<String> availableMembers;
  final double totalAmount;
  final SplitSelection? currentSplit;

  const SplitSelectionModal({
    super.key,
    required this.availableMembers,
    required this.totalAmount,
    this.currentSplit,
  });

  static Future<SplitSelection?> show(
    BuildContext context, {
    required List<String> availableMembers,
    required double totalAmount,
    SplitSelection? currentSplit,
  }) {
    return showModalBottomSheet<SplitSelection>(
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
        child: SplitSelectionModal(
          availableMembers: availableMembers,
          totalAmount: totalAmount,
          currentSplit: currentSplit,
        ),
      ),
    );
  }

  @override
  State<SplitSelectionModal> createState() => _SplitSelectionModalState();
}

class _SplitSelectionModalState extends State<SplitSelectionModal> {
  late SplitType selectedType;
  late Set<String> selectedParticipants;
  late Map<String, TextEditingController> amountControllers;
  late Map<String, double> customAmounts;

  @override
  void initState() {
    super.initState();
    
    selectedType = widget.currentSplit?.type ?? SplitType.equal;
    selectedParticipants = Set<String>.from(
      widget.currentSplit?.participants ?? widget.availableMembers
    );
    
    customAmounts = Map<String, double>.from(widget.currentSplit?.customAmounts ?? {});
    
    // Initialize controllers for custom amounts
    amountControllers = {};
    for (String member in widget.availableMembers) {
      amountControllers[member] = TextEditingController(
        text: customAmounts[member]?.toStringAsFixed(2) ?? '0.00'
      );
    }
  }

  @override
  void dispose() {
    for (var controller in amountControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  double get equalSplitAmount {
    if (selectedParticipants.isEmpty) return 0.0;
    return widget.totalAmount / selectedParticipants.length;
  }

  double get totalCustomAmount {
    return customAmounts.values.fold(0.0, (sum, amount) => sum + amount);
  }

  bool get isCustomSplitValid {
    return (totalCustomAmount - widget.totalAmount).abs() < 0.01;
  }

  void _updateCustomAmount(String member, String value) {
    double amount = double.tryParse(value) ?? 0.0;
    setState(() {
      customAmounts[member] = amount;
    });
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
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Iconsax.percentage_circle,
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
                            'Split Expense',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Total: \$${widget.totalAmount.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Split type selection
                      Text(
                        'Split Type',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSplitTypeCard(
                              type: SplitType.equal,
                              title: 'Equal Split',
                              icon: Iconsax.percentage_circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSplitTypeCard(
                              type: SplitType.custom,
                              title: 'Custom Split',
                              icon: Iconsax.edit_2,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Participants section
                      Text(
                        selectedType == SplitType.equal 
                            ? 'Select Participants' 
                            : 'Set Custom Amounts',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      if (selectedType == SplitType.equal)
                        ..._buildEqualSplitParticipants()
                      else
                        ..._buildCustomSplitAmounts(),
                        
                      const SizedBox(height: 24),
                      
                      // Summary
                      _buildSummary(),
                    ],
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
                      child: ElevatedButton(
                        onPressed: _canSave ? _handleSave : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('Apply Split'),
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

  Widget _buildSplitTypeCard({
    required SplitType type,
    required String title,
    required IconData icon,
  }) {
    final isSelected = selectedType == type;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = type;
          if (type == SplitType.equal) {
            // Reset custom amounts when switching to equal
            customAmounts.clear();
          }
        });
      },
      child: Container(
        height: 100, // Fixed height for consistency
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppTheme.primaryColor.withValues(alpha: 0.1)
              : Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: isSelected 
                ? AppTheme.primaryColor 
                : Theme.of(context).dividerColor.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? AppTheme.primaryColor : null,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildEqualSplitParticipants() {
    return widget.availableMembers.map((member) {
      final isSelected = selectedParticipants.contains(member);
      
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
            ),
          ),
          leading: CircleAvatar(
            backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
            child: Text(
              member[0].toUpperCase(),
              style: const TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          title: Text(member),
          subtitle: isSelected 
              ? Text('\$${equalSplitAmount.toStringAsFixed(2)}')
              : null,
          trailing: Checkbox(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  selectedParticipants.add(member);
                } else {
                  selectedParticipants.remove(member);
                }
              });
            },
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildCustomSplitAmounts() {
    return widget.availableMembers.map((member) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
              child: Text(
                member[0].toUpperCase(),
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                member,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: amountControllers[member],
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: '0.00',
                  prefixText: '\$',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) => _updateCustomAmount(member, value),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildSummary() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Amount:'),
              Text('\$${widget.totalAmount.toStringAsFixed(2)}'),
            ],
          ),
          const SizedBox(height: 4),
          if (selectedType == SplitType.equal) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Participants:'),
                Text('${selectedParticipants.length}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Per Person:'),
                Text('\$${equalSplitAmount.toStringAsFixed(2)}'),
              ],
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Custom Total:'),
                Text(
                  '\$${totalCustomAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: isCustomSplitValid ? Colors.green : AppTheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (!isCustomSplitValid) ...[
              const SizedBox(height: 4),
              Text(
                'Amounts must total \$${widget.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppTheme.error,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  bool get _canSave {
    if (selectedType == SplitType.equal) {
      return selectedParticipants.isNotEmpty;
    } else {
      return isCustomSplitValid && customAmounts.values.any((amount) => amount > 0);
    }
  }

  void _handleSave() {
    final result = SplitSelection(
      type: selectedType,
      participants: selectedType == SplitType.equal 
          ? selectedParticipants.toList()
          : customAmounts.entries
              .where((entry) => entry.value > 0)
              .map((entry) => entry.key)
              .toList(),
      customAmounts: selectedType == SplitType.custom ? customAmounts : {},
    );
    
    Navigator.of(context).pop(result);
  }
}