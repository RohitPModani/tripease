import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../themes/app_theme.dart';
import '../models/trip.dart';
import '../providers/trip_provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/currency_formatter.dart';
import '../utils/form_validators.dart';

class EditTripScreen extends StatefulWidget {
  final Trip trip;

  const EditTripScreen({super.key, required this.trip});

  static void show(BuildContext context, Trip trip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => EditTripScreen(trip: trip),
    );
  }

  @override
  State<EditTripScreen> createState() => _EditTripScreenState();
}

class _EditTripScreenState extends State<EditTripScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _destinationController;
  
  List<String> _destinations = [];
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedCurrency = 'USD';
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _currencies = CurrencyFormatter.getAllSupportedCurrencies();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _destinationController = TextEditingController();
    _initializeFromTrip();
  }

  void _initializeFromTrip() {
    _titleController.text = widget.trip.title;
    _descriptionController.text = widget.trip.description;
    _destinations = List.from(widget.trip.destinations);
    _startDate = widget.trip.startDate;
    _endDate = widget.trip.endDate;
    _selectedCurrency = widget.trip.defaultCurrency;
  }

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
      // Validate destination length
      if (destination.length > FormValidators.locationLimit) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Destination must be ${FormValidators.locationLimit} characters or less'),
            backgroundColor: AppTheme.error,
          ),
        );
        return;
      }
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

  void _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1095)), // 3 years
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppTheme.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;
        // Ensure end date is after start date
        if (_endDate != null && _endDate!.isBefore(picked)) {
          _endDate = picked.add(const Duration(days: 1));
        }
      });
    }
  }

  void _selectEndDate() async {
    if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.selectStartDateFirst),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate!.add(const Duration(days: 7)),
      firstDate: _startDate!,
      lastDate: DateTime.now().add(const Duration(days: 1095)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppTheme.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  void _saveTrip() async {
    if (!_formKey.currentState!.validate()) return;
    if (_destinations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.addAtLeastOneDestination),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.selectBothStartAndEndDates),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    try {
      final updatedTrip = widget.trip.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        destinations: _destinations,
        startDate: _startDate!,
        endDate: _endDate!,
        defaultCurrency: _selectedCurrency,
      );

      await Provider.of<TripProvider>(context, listen: false).updateTrip(updatedTrip);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.tripUpdatedSuccessfully),
            backgroundColor: AppTheme.success,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.failedToUpdateTrip),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
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
              color: AppTheme.textSecondary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildTitleField(),
                  const SizedBox(height: 16),
                  _buildDestinationsField(),
                  const SizedBox(height: 16),
                  _buildDatesField(),
                  const SizedBox(height: 16),
                  _buildCurrencyField(),
                  const SizedBox(height: 16),
                  _buildDescriptionField(),
                  const SizedBox(height: 24),
                  _buildButtons(),
                ],
                  ),
                ),
              ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Iconsax.edit_2,
            color: AppTheme.primaryColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          AppLocalizations.of(context)!.editTrip,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: FormValidators.createRequiredInputDecoration(
        labelText: AppLocalizations.of(context)!.title,
        maxLength: FormValidators.titleLimit,
      ).copyWith(
        labelStyle: TextStyle(color: AppTheme.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      validator: FormValidators.validateTitle,
      autofocus: true,
    );
  }

  Widget _buildDestinationsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _destinationController,
                decoration: FormValidators.createOptionalInputDecoration(
                  labelText: 'Destinations',
                  maxLength: FormValidators.locationLimit,
                ).copyWith(
                  labelStyle: TextStyle(color: AppTheme.textSecondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return FormValidators.validateDestination(value);
                  }
                  return null;
                },
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
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        if (_destinations.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _destinations.map((destination) {
              return _buildDestinationChip(destination);
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildDatesField() {
    return Column(
      children: [
        InkWell(
          onTap: _selectStartDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.calendar_1,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  _startDate == null
                      ? 'Select Start Date'
                      : 'Start: ${_startDate!.day}/${_startDate!.month}/${_startDate!.year}',
                  style: TextStyle(
                    color: _startDate == null 
                        ? AppTheme.textSecondary 
                        : Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const Spacer(),
                if (_startDate != null)
                  IconButton(
                    icon: Icon(
                      Iconsax.close_circle,
                      color: AppTheme.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _startDate = null;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: _selectEndDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.calendar_2,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  _endDate == null
                      ? 'Select End Date'
                      : 'End: ${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                  style: TextStyle(
                    color: _endDate == null 
                        ? AppTheme.textSecondary 
                        : Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const Spacer(),
                if (_endDate != null)
                  IconButton(
                    icon: Icon(
                      Iconsax.close_circle,
                      color: AppTheme.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _endDate = null;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationChip(String destination) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Iconsax.location,
            size: 12,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: 4),
          Text(
            destination,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => _removeDestination(destination),
            child: Icon(
              Iconsax.close_circle,
              size: 14,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyField() {
    return DropdownButtonFormField<String>(
      value: _selectedCurrency,
      decoration: InputDecoration(
        labelText: 'Currency',
        labelStyle: TextStyle(color: AppTheme.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      items: _currencies.map((currency) {
        return DropdownMenuItem(
          value: currency,
          child: Text(CurrencyFormatter.getCurrencyDisplayName(currency)),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedCurrency = value;
          });
        }
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: FormValidators.createOptionalInputDecoration(
        labelText: AppLocalizations.of(context)!.descriptionOptional,
        maxLength: FormValidators.descriptionLimit,
      ).copyWith(
        labelStyle: TextStyle(color: AppTheme.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      validator: FormValidators.validateDescription,
      maxLines: 3,
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
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
              onPressed: _isLoading ? null : _saveTrip,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      AppLocalizations.of(context)!.updateTrip,
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
    );
  }
}