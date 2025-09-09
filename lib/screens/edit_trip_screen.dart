import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: EditTripScreen(trip: trip),
      ),
    );
  }

  @override
  State<EditTripScreen> createState() => _EditTripScreenState();
}

class _EditTripScreenState extends State<EditTripScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _destinationController;
  late final FocusNode _titleFocusNode;
  late final FocusNode _descriptionFocusNode;
  late final FocusNode _destinationFocusNode;

  List<String> _destinations = [];
  DateTime? _startDate;
  DateTime? _endDate;
  DateRangePickerController _dateRangeController = DateRangePickerController();
  String _selectedCurrency = 'USD';
  bool _isLoading = false;
  bool _showDatePicker = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Character count state
  int titleCharCount = 0;
  int descriptionCharCount = 0;
  int destinationCharCount = 0;

  // Validation error state
  String? titleError;
  String? descriptionError;

  final List<String> _currencies =
      CurrencyFormatter.getAllSupportedCurrencies();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _destinationController = TextEditingController();
    _titleFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
    _destinationFocusNode = FocusNode();
    _initializeFromTrip();

    // Initialize character counts after setting text
    titleCharCount = _titleController.text.length;
    descriptionCharCount = _descriptionController.text.length;
    destinationCharCount = _destinationController.text.length;
  }

  void _initializeFromTrip() {
    _titleController.text = widget.trip.title;
    _descriptionController.text = widget.trip.description;
    _destinations = List.from(widget.trip.destinations);
    _startDate = widget.trip.startDate;
    _endDate = widget.trip.endDate;
    _selectedCurrency = widget.trip.defaultCurrency;

    // Initialize date range controller with existing dates
    if (_startDate != null && _endDate != null) {
      _dateRangeController.selectedRange = PickerDateRange(
        _startDate,
        _endDate,
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _destinationController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _destinationFocusNode.dispose();
    _dateRangeController.dispose();
    super.dispose();
  }

  void _addDestination() {
    final destination = _destinationController.text.trim();
    if (destination.isNotEmpty && !_destinations.contains(destination)) {
      // Validate destination length
      if (destination.length > FormValidators.locationLimit) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Destination must be ${FormValidators.locationLimit} characters or less',
            ),
            backgroundColor: AppTheme.error,
          ),
        );
        return;
      }
      setState(() {
        _destinations.add(destination);
        _destinationController.clear();
        destinationCharCount = 0;
      });
    }
  }

  void _removeDestination(String destination) {
    setState(() {
      _destinations.remove(destination);
    });
  }

  void _toggleDatePicker() {
    setState(() {
      _showDatePicker = !_showDatePicker;
    });
  }

  void _onDateRangeChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final PickerDateRange range = args.value;
      setState(() {
        _startDate = range.startDate;
        _endDate = range.endDate;
      });
    }
  }

  void _clearDateRange() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _dateRangeController.selectedRange = null;
    });
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
          content: Text(
            AppLocalizations.of(context)!.selectBothStartAndEndDates,
          ),
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

      await Provider.of<TripProvider>(
        context,
        listen: false,
      ).updateTrip(updatedTrip);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.tripUpdatedSuccessfully,
            ),
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
                  color: AppTheme.textSecondary.withOpacity(0.3),
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
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      focusNode: _titleFocusNode,
      maxLength: FormValidators.titleLimit,
      onChanged: (value) {
        setState(() {
          titleCharCount = value.length;
          titleError = FormValidators.validateTitle(value, context);
        });
      },
      decoration:
          FormValidators.createRequiredInputDecoration(
            labelText: AppLocalizations.of(context)!.title,
            maxLength: FormValidators.titleLimit,
            context: context,
          ).copyWith(
            labelStyle: TextStyle(color: AppTheme.textSecondary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.textSecondary.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppTheme.primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.error, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.error, width: 2),
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
                focusNode: _destinationFocusNode,
                maxLength: FormValidators.locationLimit,
                onChanged: (value) {
                  setState(() {
                    destinationCharCount = value.length;
                  });
                },
                decoration:
                    FormValidators.createOptionalInputDecoration(
                      labelText: 'Destinations',
                      maxLength: FormValidators.locationLimit,
                      context: context,
                    ).copyWith(
                      labelStyle: TextStyle(color: AppTheme.textSecondary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppTheme.textSecondary.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppTheme.primaryColor,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      counterText: '',
                      suffixText: '$destinationCharCount/${FormValidators.locationLimit}',
                      suffixStyle: TextStyle(
                        fontSize: 12,
                        color: destinationCharCount > FormValidators.locationLimit
                            ? AppTheme.error
                            : AppTheme.textSecondary,
                      ),
                    ),
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return FormValidators.validateDestination(value, context);
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
                icon: const Icon(Iconsax.add, color: Colors.white, size: 20),
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
          onTap: _toggleDatePicker,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: _showDatePicker
                    ? AppTheme.primaryColor
                    : AppTheme.textSecondary.withOpacity(0.3),
                width: _showDatePicker ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Iconsax.calendar, color: AppTheme.primaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Travel Dates',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _startDate == null
                            ? 'Select date range'
                            : _endDate == null
                            ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year} - Select end date'
                            : '${_startDate!.day}/${_startDate!.month}/${_startDate!.year} - ${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                        style: TextStyle(
                          color: _startDate == null
                              ? AppTheme.textSecondary
                              : Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_startDate != null || _endDate != null)
                  IconButton(
                    icon: Icon(
                      Iconsax.close_circle,
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                    onPressed: _clearDateRange,
                  ),
                Icon(
                  _showDatePicker ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (_showDatePicker) ...[
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SfDateRangePicker(
                controller: _dateRangeController,
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.range,
                startRangeSelectionColor: AppTheme.primaryColor,
                endRangeSelectionColor: AppTheme.primaryColor,
                rangeSelectionColor: AppTheme.primaryColor.withOpacity(0.1),
                todayHighlightColor: AppTheme.primaryColor,
                selectionTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                rangeTextStyle: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                minDate: DateTime.now().subtract(const Duration(days: 365)),
                maxDate: DateTime.now().add(const Duration(days: 365 * 3)),
                onSelectionChanged: _onDateRangeChanged,
                monthViewSettings: DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    textStyle: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  todayTextStyle: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  disabledDatesTextStyle: TextStyle(
                    color: AppTheme.textSecondary.withOpacity(0.5),
                  ),
                ),
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          if (_startDate != null && _endDate != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.calendar_tick,
                      color: AppTheme.primaryColor,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${_endDate!.difference(_startDate!).inDays + 1} days selected',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildDestinationChip(String destination) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Iconsax.location, size: 12, color: AppTheme.primaryColor),
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
          borderSide: BorderSide(
            color: AppTheme.textSecondary.withOpacity(0.3),
          ),
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
      focusNode: _descriptionFocusNode,
      maxLength: FormValidators.descriptionLimit,
      onChanged: (value) {
        setState(() {
          descriptionCharCount = value.length;
          descriptionError = FormValidators.validateDescription(value, context);
        });
      },
      decoration:
          FormValidators.createOptionalInputDecoration(
            labelText: AppLocalizations.of(context)!.descriptionOptional,
            maxLength: FormValidators.descriptionLimit,
            context: context,
          ).copyWith(
            labelStyle: TextStyle(color: AppTheme.textSecondary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.textSecondary.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppTheme.primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.error, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.error, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
            counterText: '',
            suffixText:
                '$descriptionCharCount/${FormValidators.descriptionLimit}',
            suffixStyle: TextStyle(
              fontSize: 12,
              color: descriptionCharCount > FormValidators.descriptionLimit
                  ? AppTheme.error
                  : AppTheme.textSecondary,
            ),
            errorText: descriptionError,
          ),
      validator: (value) => FormValidators.validateDescription(value, context),
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
