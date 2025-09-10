import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../themes/app_theme.dart';
import '../utils/form_validators.dart';
import '../l10n/app_localizations.dart';

enum ActivityType {
  sightseeing,
  meal,
  transport,
  accommodation,
  shopping,
  entertainment,
  other,
}

class ItineraryActivity {
  final String title;
  final ActivityType type;
  final String description;
  final String location;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  
  ItineraryActivity({
    required this.title,
    required this.type,
    this.description = '',
    this.location = '',
    this.startTime,
    this.endTime,
  });
}

class ItineraryFormModal extends StatefulWidget {
  final String tripId;
  final DateTime? selectedDate;
  final ItineraryActivity? activity;
  final Function(ItineraryActivity, DateTime) onActivityAdded;
  final DateTime? tripStartDate;
  final DateTime? tripEndDate;

  const ItineraryFormModal({
    super.key,
    required this.tripId,
    required this.onActivityAdded,
    this.selectedDate,
    this.activity,
    this.tripStartDate,
    this.tripEndDate,
  });

  // Helper to present the modal from anywhere
  static void show(
    BuildContext context,
    String tripId,
    Function(ItineraryActivity, DateTime) onActivityAdded, {
    DateTime? selectedDate,
    ItineraryActivity? activity,
    DateTime? tripStartDate,
    DateTime? tripEndDate,
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
        child: ItineraryFormModal(
          tripId: tripId,
          onActivityAdded: onActivityAdded,
          selectedDate: selectedDate,
          activity: activity,
          tripStartDate: tripStartDate,
          tripEndDate: tripEndDate,
        ),
      ),
    );
  }

  @override
  State<ItineraryFormModal> createState() => _ItineraryFormModalState();
}

class _ItineraryFormModalState extends State<ItineraryFormModal> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController locationController;
  late final ScrollController _scrollController;
  late final FocusNode _titleFocusNode;
  late final FocusNode _descriptionFocusNode;
  late final FocusNode _locationFocusNode;
  
  late ActivityType selectedType;
  late DateTime selectedActivityDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Character count state
  int titleCharCount = 0;
  int locationCharCount = 0;
  int descriptionCharCount = 0;
  
  // Validation error state
  String? titleError;
  String? locationError;
  String? descriptionError;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.activity?.title ?? '');
    descriptionController = TextEditingController(text: widget.activity?.description ?? '');
    locationController = TextEditingController(text: widget.activity?.location ?? '');
    _scrollController = ScrollController();
    _titleFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
    _locationFocusNode = FocusNode();
    
    selectedType = widget.activity?.type ?? ActivityType.sightseeing;
    
    // Initialize selectedActivityDate - prioritize trip start date as default
    if (widget.selectedDate != null) {
      selectedActivityDate = widget.selectedDate!;
    } else if (widget.tripStartDate != null) {
      // Always use trip start date as default when available
      selectedActivityDate = widget.tripStartDate!;
    } else {
      // Fallback to current date only if no trip start date
      selectedActivityDate = DateTime.now();
    }
    
    selectedStartTime = widget.activity?.startTime;
    selectedEndTime = widget.activity?.endTime;
    
    // Initialize character counts
    titleCharCount = titleController.text.length;
    locationCharCount = locationController.text.length;
    descriptionCharCount = descriptionController.text.length;

    // Add focus listeners for auto-scroll
    _titleFocusNode.addListener(() {
      if (_titleFocusNode.hasFocus) {
        _scrollToField(0.0);
      }
    });
    
    _descriptionFocusNode.addListener(() {
      if (_descriptionFocusNode.hasFocus) {
        _scrollToField(200.0);
      }
    });

    _locationFocusNode.addListener(() {
      if (_locationFocusNode.hasFocus) {
        _scrollToField(150.0);
      }
    });
  }

  void _scrollToField(double offset) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    _scrollController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.activity != null;

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
                controller: _scrollController,
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
                            color: AppTheme.warning.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Iconsax.location,
                            color: AppTheme.warning,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          isEdit ? AppLocalizations.of(context)!.editActivity : AppLocalizations.of(context)!.addNewActivity,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: titleController,
                      focusNode: _titleFocusNode,
                      maxLength: FormValidators.titleLimit,
                      onChanged: (value) {
                        setState(() {
                          titleCharCount = value.length;
                          titleError = FormValidators.validateTitle(value, context);
                        });
                      },
                      decoration: FormValidators.createRequiredInputDecoration(
                        labelText: AppLocalizations.of(context)!.activityTitle,
                        maxLength: FormValidators.titleLimit,
                        context: context,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.warning, width: 2),
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
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<ActivityType>(
                      value: selectedType,
                      decoration: FormValidators.createOptionalInputDecoration(
                        labelText: AppLocalizations.of(context)!.activityType,
                        maxLength: 0, // Not applicable for dropdown
                        context: context,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.warning, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        suffixText: null, // Remove character counter for dropdown
                      ),
                      items: ActivityType.values
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Row(
                                  children: [
                                    Icon(_getActivityTypeIcon(type), size: 16),
                                    const SizedBox(width: 8),
                                    Text(_getActivityTypeDisplayName(type)),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedType = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: locationController,
                      focusNode: _locationFocusNode,
                      maxLength: FormValidators.locationLimit,
                      onChanged: (value) {
                        setState(() {
                          locationCharCount = value.length;
                          locationError = FormValidators.validateLocation(value, context);
                        });
                      },
                      decoration: FormValidators.createOptionalInputDecoration(
                        labelText: AppLocalizations.of(context)!.location,
                        maxLength: FormValidators.locationLimit,
                        context: context,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.warning, width: 2),
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
                        suffixText: '$locationCharCount/${FormValidators.locationLimit}',
                        suffixStyle: TextStyle(
                          fontSize: 12,
                          color: locationCharCount > FormValidators.locationLimit 
                              ? AppTheme.error 
                              : AppTheme.textSecondary,
                        ),
                        errorText: locationError,
                      ),
                      validator: (value) => FormValidators.validateLocation(value, context),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        // Ensure we have valid date range
                        final firstDate = widget.tripStartDate ?? DateTime.now();
                        final lastDate = widget.tripEndDate ?? DateTime.now().add(const Duration(days: 30));
                        
                        // Make sure firstDate is not after lastDate
                        final validFirstDate = firstDate.isAfter(lastDate) ? lastDate : firstDate;
                        final validLastDate = lastDate.isBefore(firstDate) ? firstDate : lastDate;
                        
                        // Ensure initial date is within valid range
                        DateTime initialDate = selectedActivityDate;
                        if (initialDate.isBefore(validFirstDate)) {
                          initialDate = validFirstDate;
                        } else if (initialDate.isAfter(validLastDate)) {
                          initialDate = validLastDate;
                        }
                        
                        final date = await showDatePicker(
                          context: context,
                          initialDate: initialDate,
                          firstDate: validFirstDate,
                          lastDate: validLastDate,
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: Theme.of(context).colorScheme.copyWith(
                                  primary: AppTheme.warning,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (date != null) {
                          setState(() {
                            selectedActivityDate = date;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.calendar_1,
                              color: AppTheme.warning,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Date: ${selectedActivityDate.day}/${selectedActivityDate.month}/${selectedActivityDate.year}',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: selectedStartTime ?? TimeOfDay.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: Theme.of(context).colorScheme.copyWith(
                                        primary: AppTheme.warning,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (time != null) {
                                setState(() {
                                  selectedStartTime = time;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.clock,
                                    color: AppTheme.warning,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      selectedStartTime == null
                                          ? AppLocalizations.of(context)!.startTime
                                          : _formatTime(selectedStartTime!),
                                      style: TextStyle(
                                        color: selectedStartTime == null
                                            ? AppTheme.textSecondary
                                            : Theme.of(context).textTheme.bodyMedium?.color,
                                      ),
                                    ),
                                  ),
                                  if (selectedStartTime != null)
                                    IconButton(
                                      icon: Icon(
                                        Iconsax.close_circle,
                                        color: AppTheme.textSecondary,
                                        size: 16,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          selectedStartTime = null;
                                        });
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: selectedEndTime ?? 
                                    (selectedStartTime?.replacing(hour: selectedStartTime!.hour + 1) ?? TimeOfDay.now()),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: Theme.of(context).colorScheme.copyWith(
                                        primary: AppTheme.warning,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (time != null) {
                                setState(() {
                                  selectedEndTime = time;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.clock,
                                    color: AppTheme.warning,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      selectedEndTime == null
                                          ? AppLocalizations.of(context)!.endTime
                                          : _formatTime(selectedEndTime!),
                                      style: TextStyle(
                                        color: selectedEndTime == null
                                            ? AppTheme.textSecondary
                                            : Theme.of(context).textTheme.bodyMedium?.color,
                                      ),
                                    ),
                                  ),
                                  if (selectedEndTime != null)
                                    IconButton(
                                      icon: Icon(
                                        Iconsax.close_circle,
                                        color: AppTheme.textSecondary,
                                        size: 16,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          selectedEndTime = null;
                                        });
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      focusNode: _descriptionFocusNode,
                      maxLength: FormValidators.itineraryDescriptionLimit,
                      onChanged: (value) {
                        setState(() {
                          descriptionCharCount = value.length;
                          descriptionError = FormValidators.validateItineraryDescription(value, context);
                        });
                      },
                      decoration: FormValidators.createOptionalInputDecoration(
                        labelText: AppLocalizations.of(context)!.description,
                        maxLength: FormValidators.itineraryDescriptionLimit,
                        context: context,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.warning, width: 2),
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
                        suffixText: '$descriptionCharCount/${FormValidators.itineraryDescriptionLimit}',
                        suffixStyle: TextStyle(
                          fontSize: 12,
                          color: descriptionCharCount > FormValidators.itineraryDescriptionLimit 
                              ? AppTheme.error 
                              : AppTheme.textSecondary,
                        ),
                        errorText: descriptionError,
                      ),
                      validator: (value) => FormValidators.validateItineraryDescription(value, context),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
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
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) return;

                                final newActivity = ItineraryActivity(
                                  title: titleController.text.trim(),
                                  type: selectedType,
                                  description: descriptionController.text.trim(),
                                  location: locationController.text.trim(),
                                  startTime: selectedStartTime,
                                  endTime: selectedEndTime,
                                );

                                widget.onActivityAdded(newActivity, selectedActivityDate);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                isEdit ? AppLocalizations.of(context)!.updateActivity : AppLocalizations.of(context)!.addActivity,
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

  IconData _getActivityTypeIcon(ActivityType type) {
    switch (type) {
      case ActivityType.sightseeing:
        return Iconsax.camera;
      case ActivityType.meal:
        return Iconsax.cup;
      case ActivityType.transport:
        return Iconsax.car;
      case ActivityType.accommodation:
        return Iconsax.building_4;
      case ActivityType.shopping:
        return Iconsax.bag_2;
      case ActivityType.entertainment:
        return Iconsax.music_play;
      case ActivityType.other:
        return Iconsax.note_1;
    }
  }

  String _getActivityTypeDisplayName(ActivityType type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case ActivityType.sightseeing:
        return l10n.sightseeing;
      case ActivityType.meal:
        return l10n.meal;
      case ActivityType.transport:
        return l10n.transport;
      case ActivityType.accommodation:
        return l10n.accommodation;
      case ActivityType.shopping:
        return l10n.shopping;
      case ActivityType.entertainment:
        return l10n.entertainment;
      case ActivityType.other:
        return l10n.other;
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
