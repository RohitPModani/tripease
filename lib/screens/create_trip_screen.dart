import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import '../themes/app_theme.dart';
import '../models/trip.dart';
import '../providers/trip_provider.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({super.key});

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _destinationController = TextEditingController();
  
  List<String> _destinations = [];
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedCurrency = 'USD';
  bool _isLoading = false;

  final List<String> _currencies = [
    'USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD', 'CHF', 'CNY', 'INR', 'KRW'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _addDestination() {
    final destination = _destinationController.text.trim();
    if (destination.isNotEmpty && !_destinations.contains(destination)) {
      setState(() {
        _destinations.add(destination);
        _destinationController.clear();
      });
    }
  }

  void _removeDestination(String destination) {
    setState(() {
      _destinations.remove(destination);
    });
  }

  Future<void> _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppTheme.primaryColor,
              onPrimary: AppTheme.textLight,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (date != null) {
      setState(() {
        _startDate = date;
        if (_endDate != null && _endDate!.isBefore(date)) {
          _endDate = null;
        }
      });
    }
  }

  Future<void> _selectEndDate() async {
    if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select start date first')),
      );
      return;
    }

    final date = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate!.add(const Duration(days: 7)),
      firstDate: _startDate!,
      lastDate: _startDate!.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppTheme.primaryColor,
              onPrimary: AppTheme.textLight,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (date != null) {
      setState(() {
        _endDate = date;
      });
    }
  }

  Future<void> _createTrip() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_destinations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one destination')),
      );
      return;
    }

    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select start and end dates')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final trip = Trip(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        destinations: _destinations,
        startDate: _startDate!,
        endDate: _endDate!,
        description: _descriptionController.text.trim(),
        defaultCurrency: _selectedCurrency,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await Provider.of<TripProvider>(context, listen: false).createTrip(trip);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trip created successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating trip: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Trip'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Iconsax.arrow_left_2,
              color: AppTheme.primaryColor,
              size: 20,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.backgroundDark
                  : AppTheme.backgroundLight,
              Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.surfaceDark.withOpacity(0.8)
                  : AppTheme.surfaceLight.withOpacity(0.8),
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildTitleSection(),
              const SizedBox(height: 24),
              _buildDestinationsSection(),
              const SizedBox(height: 24),
              _buildDatesSection(),
              const SizedBox(height: 24),
              _buildDescriptionSection(),
              const SizedBox(height: 24),
              _buildCurrencySection(),
              const SizedBox(height: 32),
              _buildCreateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      decoration: Theme.of(context).brightness == Brightness.dark
          ? AppTheme.pixieCardDecorationDark
          : AppTheme.pixieCardDecoration,
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Iconsax.edit,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Trip Details',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Trip Title',
              hintText: 'e.g., European Adventure',
              prefixIcon: Icon(Iconsax.airplane),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a trip title';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationsSection() {
    return Container(
      decoration: Theme.of(context).brightness == Brightness.dark
          ? AppTheme.pixieCardDecorationDark
          : AppTheme.pixieCardDecoration,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Iconsax.location,
                  color: AppTheme.accentColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Destinations',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _destinationController,
                  decoration: const InputDecoration(
                    labelText: 'Add Destination',
                    hintText: 'e.g., Paris, Tokyo, New York',
                    prefixIcon: Icon(Iconsax.map),
                  ),
                  onFieldSubmitted: (_) => _addDestination(),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: AppTheme.glowingButtonDecoration,
                child: IconButton(
                  onPressed: _addDestination,
                  icon: const Icon(
                    Iconsax.add,
                    color: AppTheme.textLight,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          if (_destinations.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _destinations.map((destination) {
                return _buildDestinationChip(destination);
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDatesSection() {
    return Container(
      decoration: Theme.of(context).brightness == Brightness.dark
          ? AppTheme.pixieCardDecorationDark
          : AppTheme.pixieCardDecoration,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Iconsax.calendar,
                  color: AppTheme.secondaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Travel Dates',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDateButton(
                  label: 'Start Date',
                  date: _startDate,
                  onTap: _selectStartDate,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDateButton(
                  label: 'End Date',
                  date: _endDate,
                  onTap: _selectEndDate,
                ),
              ),
            ],
          ),
          if (_startDate != null && _endDate != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Iconsax.timer,
                    color: AppTheme.success,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Duration: ${_endDate!.difference(_startDate!).inDays + 1} days',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDateButton({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.textSecondary.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Iconsax.calendar_1,
                  size: 16,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  date != null 
                      ? '${date.day}/${date.month}/${date.year}'
                      : 'Select date',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: date != null ? null : AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
      decoration: Theme.of(context).brightness == Brightness.dark
          ? AppTheme.pixieCardDecorationDark
          : AppTheme.pixieCardDecoration,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Iconsax.note_text,
                  color: AppTheme.warning,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Description (Optional)',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Trip Description',
              hintText: 'Tell us about your upcoming adventure...',
              prefixIcon: Icon(Iconsax.document_text),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencySection() {
    return Container(
      decoration: Theme.of(context).brightness == Brightness.dark
          ? AppTheme.pixieCardDecorationDark
          : AppTheme.pixieCardDecoration,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Iconsax.dollar_circle,
                  color: AppTheme.success,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Default Currency',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedCurrency,
            decoration: const InputDecoration(
              labelText: 'Select Currency',
              prefixIcon: Icon(Iconsax.money),
            ),
            items: _currencies.map((currency) {
              return DropdownMenuItem(
                value: currency,
                child: Text(currency),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedCurrency = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationChip(String destination) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.accentColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Iconsax.location,
            size: 12,
            color: AppTheme.accentColor,
          ),
          const SizedBox(width: 4),
          Text(
            destination,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.accentColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => _removeDestination(destination),
            child: Icon(
              Iconsax.close_circle,
              size: 14,
              color: AppTheme.accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton() {
    return Container(
      decoration: AppTheme.glowingButtonDecoration,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _createTrip,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppTheme.textLight,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.add_circle,
                    color: AppTheme.textLight,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Create Trip',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.textLight,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}