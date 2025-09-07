import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../themes/app_theme.dart';
import '../utils/form_validators.dart';

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ItineraryFormModal(
        tripId: tripId,
        onActivityAdded: onActivityAdded,
        selectedDate: selectedDate,
        activity: activity,
        tripStartDate: tripStartDate,
        tripEndDate: tripEndDate,
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
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.activity != null;

    return Container(
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
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.warning.withOpacity(0.1),
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
                          isEdit ? 'Edit Activity' : 'Add New Activity',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
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
                          titleError = FormValidators.validateTitle(value);
                        });
                      },
                      decoration: FormValidators.createRequiredInputDecoration(
                        labelText: 'Activity Title',
                        maxLength: FormValidators.titleLimit,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
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
                      validator: FormValidators.validateTitle,
                      autofocus: true,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<ActivityType>(
                      value: selectedType,
                      decoration: InputDecoration(
                        labelText: 'Activity Type',
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.warning, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(16),
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
                      maxLength: FormValidators.locationLimit,
                      onChanged: (value) {
                        setState(() {
                          locationCharCount = value.length;
                          locationError = FormValidators.validateLocation(value);
                        });
                      },
                      decoration: FormValidators.createOptionalInputDecoration(
                        labelText: 'Location',
                        maxLength: FormValidators.locationLimit,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
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
                      validator: FormValidators.validateLocation,
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
                          border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
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
                                border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
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
                                          ? 'Start Time'
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
                                border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
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
                                          ? 'End Time'
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
                      maxLength: FormValidators.itineraryDescriptionLimit,
                      onChanged: (value) {
                        setState(() {
                          descriptionCharCount = value.length;
                          descriptionError = FormValidators.validateItineraryDescription(value);
                        });
                      },
                      decoration: FormValidators.createOptionalInputDecoration(
                        labelText: 'Description',
                        maxLength: FormValidators.itineraryDescriptionLimit,
                      ).copyWith(
                        labelStyle: TextStyle(color: AppTheme.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
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
                      validator: FormValidators.validateItineraryDescription,
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
                              side: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Cancel',
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
                                isEdit ? 'Update Activity' : 'Add Activity',
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
    switch (type) {
      case ActivityType.sightseeing:
        return 'Sightseeing';
      case ActivityType.meal:
        return 'Meal';
      case ActivityType.transport:
        return 'Transport';
      case ActivityType.accommodation:
        return 'Accommodation';
      case ActivityType.shopping:
        return 'Shopping';
      case ActivityType.entertainment:
        return 'Entertainment';
      case ActivityType.other:
        return 'Other';
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
