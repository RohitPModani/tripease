import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../models/trip.dart';
import '../../themes/app_theme.dart';

class ItineraryTab extends StatefulWidget {
  final Trip trip;

  const ItineraryTab({super.key, required this.trip});

  @override
  State<ItineraryTab> createState() => _ItineraryTabState();
}

class _ItineraryTabState extends State<ItineraryTab> {
  List<ItineraryDay> days = [];
  int selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    _generateDays();
  }

  void _generateDays() {
    final startDate = widget.trip.startDate;
    final endDate = widget.trip.endDate;
    final duration = endDate.difference(startDate).inDays + 1;

    days = List.generate(duration, (index) {
      final date = startDate.add(Duration(days: index));
      return ItineraryDay(
        date: date,
        dayNumber: index + 1,
        activities: [],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Day selector sidebar
        Container(
          width: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.surfaceDark
                : AppTheme.surfaceLight,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(2, 0),
                blurRadius: 4,
              ),
            ],
          ),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index];
              final isSelected = selectedDayIndex == index;
              final isToday = _isSameDay(day.date, DateTime.now());
              
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected 
                      ? AppTheme.primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      decoration: isSelected
                          ? BoxDecoration(
                              border: Border.all(
                                color: AppTheme.primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            )
                          : null,
                      child: Column(
                        children: [
                          Text(
                            'Day ${day.dayNumber}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${day.date.day} ${_getShortMonthName(day.date.month)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isToday 
                                  ? AppTheme.accentColor
                                  : isSelected 
                                      ? AppTheme.primaryColor 
                                      : null,
                            ),
                          ),
                          if (day.activities.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Day details
        Expanded(
          child: _buildDayDetails(),
        ),
      ],
    );
  }

  Widget _buildDayDetails() {
    final selectedDay = days[selectedDayIndex];
    
    return Column(
      children: [
        // Day header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.surfaceDark
                : AppTheme.surfaceLight,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Day ${selectedDay.dayNumber}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(selectedDay.date),
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: AppTheme.glowingButtonDecoration,
                child: IconButton(
                  onPressed: () => _showAddActivityDialog(selectedDay),
                  icon: const Icon(
                    Iconsax.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Activities list
        Expanded(
          child: selectedDay.activities.isEmpty
              ? _buildEmptyDayState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: selectedDay.activities.length,
                  itemBuilder: (context, index) {
                    return _buildActivityItem(selectedDay.activities[index], selectedDay);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyDayState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Iconsax.calendar_add,
                size: 48,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No activities planned',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add activities to plan your perfect day!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showAddActivityDialog(days[selectedDayIndex]),
              icon: const Icon(Iconsax.add),
              label: const Text('Add Activity'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(ItineraryActivity activity, ItineraryDay day) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.surfaceDark
            : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getActivityTypeColor(activity.type).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(6),
        onTap: () => _showActivityDetailsBottomSheet(activity, day),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (activity.startTime != null)
                    Text(
                      _formatTime(activity.startTime!),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  if (activity.endTime != null && activity.startTime != null)
                    Text(
                      _formatTime(activity.endTime!),
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  if (activity.startTime == null)
                    Text(
                      'All Day',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 1,
              height: 40,
              color: AppTheme.textSecondary.withOpacity(0.2),
            ),
          ],
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: _getActivityTypeColor(activity.type).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                _getActivityTypeIcon(activity.type),
                color: _getActivityTypeColor(activity.type),
                size: 14,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                activity.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (activity.description.isNotEmpty) ...[
                Text(
                  activity.description,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (activity.location.isNotEmpty) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Iconsax.location,
                      size: 12,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        activity.location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getActivityTypeColor(ActivityType type) {
    switch (type) {
      case ActivityType.sightseeing:
        return Colors.blue;
      case ActivityType.meal:
        return Colors.orange;
      case ActivityType.transport:
        return Colors.green;
      case ActivityType.accommodation:
        return Colors.purple;
      case ActivityType.shopping:
        return Colors.pink;
      case ActivityType.entertainment:
        return Colors.red;
      case ActivityType.other:
        return AppTheme.textSecondary;
    }
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

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'
    ];
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    
    return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _getShortMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  void _showAddActivityDialog(ItineraryDay day) {
    _showActivityDialog(day);
  }

  void _showEditActivityDialog(ItineraryActivity activity, ItineraryDay day) {
    _showActivityDialog(day, activity: activity);
  }

  void _showActivityDialog(ItineraryDay day, {ItineraryActivity? activity}) {
    final isEdit = activity != null;
    final titleController = TextEditingController(text: activity?.title ?? '');
    final descriptionController = TextEditingController(text: activity?.description ?? '');
    final locationController = TextEditingController(text: activity?.location ?? '');
    
    ActivityType selectedType = activity?.type ?? ActivityType.sightseeing;
    TimeOfDay? selectedStartTime = activity?.startTime;
    TimeOfDay? selectedEndTime = activity?.endTime;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
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
                              Iconsax.calendar_add,
                              color: AppTheme.primaryColor,
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
                        decoration: InputDecoration(
                          labelText: 'Activity Title',
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
                            borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        items: ActivityType.values
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: _getActivityTypeColor(type).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Icon(
                                          _getActivityTypeIcon(type),
                                          color: _getActivityTypeColor(type),
                                          size: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(_getActivityTypeDisplayName(type)),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setModalState(() {
                              selectedType = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description (Optional)',
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
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(
                          labelText: 'Location (Optional)',
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
                                );
                                if (time != null) {
                                  setModalState(() {
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start Time',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      selectedStartTime != null
                                          ? _formatTime(selectedStartTime!)
                                          : 'Select time',
                                      style: TextStyle(
                                        color: selectedStartTime != null 
                                            ? Theme.of(context).textTheme.bodyMedium?.color
                                            : AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: selectedEndTime ?? 
                                      (selectedStartTime != null 
                                          ? TimeOfDay(
                                              hour: selectedStartTime!.hour + 1,
                                              minute: selectedStartTime!.minute,
                                            )
                                          : TimeOfDay.now()),
                                );
                                if (time != null) {
                                  setModalState(() {
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'End Time',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      selectedEndTime != null
                                          ? _formatTime(selectedEndTime!)
                                          : 'Select time',
                                      style: TextStyle(
                                        color: selectedEndTime != null 
                                            ? Theme.of(context).textTheme.bodyMedium?.color
                                            : AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                                  if (titleController.text.trim().isEmpty) return;

                                  final newActivity = ItineraryActivity(
                                    title: titleController.text.trim(),
                                    type: selectedType,
                                    description: descriptionController.text.trim(),
                                    location: locationController.text.trim(),
                                    startTime: selectedStartTime,
                                    endTime: selectedEndTime,
                                  );

                                  setState(() {
                                    if (isEdit) {
                                      final index = day.activities.indexOf(activity!);
                                      day.activities[index] = newActivity;
                                    } else {
                                      day.activities.add(newActivity);
                                      // Sort activities by start time
                                      day.activities.sort((a, b) {
                                        if (a.startTime == null && b.startTime == null) return 0;
                                        if (a.startTime == null) return 1;
                                        if (b.startTime == null) return -1;
                                        return a.startTime!.hour * 60 + a.startTime!.minute -
                                               (b.startTime!.hour * 60 + b.startTime!.minute);
                                      });
                                    }
                                  });

                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  isEdit ? 'Update Activity' : 'Add Activity',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteActivity(ItineraryActivity activity, ItineraryDay day) {
    setState(() {
      day.activities.remove(activity);
    });
  }

  void _showActivityDetailsBottomSheet(ItineraryActivity activity, ItineraryDay day) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _getActivityTypeColor(activity.type).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getActivityTypeIcon(activity.type),
                            color: _getActivityTypeColor(activity.type),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Activity Details',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _getActivityTypeDisplayName(activity.type),
                                style: TextStyle(
                                  color: _getActivityTypeColor(activity.type),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Title',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      activity.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (activity.description.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        activity.description,
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                    if (activity.location.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.location,
                            size: 16,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            activity.location,
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Type',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getActivityTypeColor(activity.type).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _getActivityTypeColor(activity.type).withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  _getActivityTypeDisplayName(activity.type),
                                  style: TextStyle(
                                    color: _getActivityTypeColor(activity.type),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (activity.startTime != null) ...[
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.clock,
                                      size: 16,
                                      color: AppTheme.primaryColor,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      activity.endTime != null
                                          ? '${_formatTime(activity.startTime!)} - ${_formatTime(activity.endTime!)}'
                                          : _formatTime(activity.startTime!),
                                      style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _showEditActivityDialog(activity, day);
                            },
                            icon: const Icon(Iconsax.edit_2),
                            label: const Text('Edit'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _deleteActivity(activity, day);
                            },
                            icon: const Icon(Iconsax.trash),
                            label: const Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.error,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItineraryDay {
  final DateTime date;
  final int dayNumber;
  final List<ItineraryActivity> activities;

  ItineraryDay({
    required this.date,
    required this.dayNumber,
    required this.activities,
  });
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

enum ActivityType {
  sightseeing,
  meal,
  transport,
  accommodation,
  shopping,
  entertainment,
  other,
}

extension ActivityTypeExtension on ActivityType {
  String get displayName {
    switch (this) {
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
}