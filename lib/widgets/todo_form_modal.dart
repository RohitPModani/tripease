import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_item.dart';
import '../themes/app_theme.dart';
import '../providers/todo_provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/form_validators.dart';
import '../utils/snackbar.dart';

class TodoFormModal extends StatefulWidget {
  final String tripId;
  final TodoItem? todo;

  const TodoFormModal({super.key, required this.tripId, this.todo});

  static void show(BuildContext context, String tripId, {TodoItem? todo}) {
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
        child: TodoFormModal(tripId: tripId, todo: todo),
      ),
    );
  }

  @override
  State<TodoFormModal> createState() => _TodoFormModalState();
}

class _TodoFormModalState extends State<TodoFormModal> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final ScrollController _scrollController;
  late final FocusNode _titleFocusNode;
  late final FocusNode _descriptionFocusNode;

  late Priority selectedPriority;
  DateTime? selectedDueDate;

  // Character count state
  int titleCharCount = 0;
  int descriptionCharCount = 0;

  // Validation error state
  String? titleError;
  String? descriptionError;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo?.title ?? '');
    descriptionController = TextEditingController(
      text: widget.todo?.description ?? '',
    );
    _scrollController = ScrollController();
    _titleFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
    selectedPriority = widget.todo?.priority ?? Priority.medium;
    selectedDueDate = widget.todo?.dueDate;

    // Initialize character counts
    titleCharCount = titleController.text.length;
    descriptionCharCount = descriptionController.text.length;

    // Add focus listeners for auto-scroll
    _titleFocusNode.addListener(() {
      if (_titleFocusNode.hasFocus) {
        _scrollToField(0.0);
      }
    });
    
    _descriptionFocusNode.addListener(() {
      if (_descriptionFocusNode.hasFocus) {
        _scrollToField(100.0);
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
    _scrollController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.todo != null;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Iconsax.task_square,
                          color: AppTheme.primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        isEdit
                            ? AppLocalizations.of(context)!.editTask
                            : AppLocalizations.of(context)!.addNewTask,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
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
                    validator: (value) => FormValidators.validateTitle(value, context),
                    decoration: FormValidators.createRequiredInputDecoration(
                      labelText: AppLocalizations.of(context)!.taskTitle,
                      maxLength: FormValidators.titleLimit,
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
                          color: AppTheme.primaryColor,
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
                      suffixText:
                          '$titleCharCount/${FormValidators.titleLimit}',
                      suffixStyle: TextStyle(
                        fontSize: 12,
                        color: titleCharCount > FormValidators.titleLimit
                            ? AppTheme.error
                            : AppTheme.textSecondary,
                      ),
                      errorText: titleError,
                    ),
                    autofocus: true,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionController,
                    focusNode: _descriptionFocusNode,
                    maxLength: FormValidators.descriptionLimit,
                    onChanged: (value) {
                      setState(() {
                        descriptionCharCount = value.length;
                        descriptionError = FormValidators.validateDescription(
                          value,
                          context,
                        );
                      });
                    },
                    validator: (value) => FormValidators.validateDescription(value, context),
                    decoration: FormValidators.createOptionalInputDecoration(
                      labelText: AppLocalizations.of(context)!.description,
                      maxLength: FormValidators.descriptionLimit,
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
                          color: AppTheme.primaryColor,
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
                      suffixText:
                          '$descriptionCharCount/${FormValidators.descriptionLimit}',
                      suffixStyle: TextStyle(
                        fontSize: 12,
                        color:
                            descriptionCharCount >
                                FormValidators.descriptionLimit
                            ? AppTheme.error
                            : AppTheme.textSecondary,
                      ),
                      errorText: descriptionError,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<Priority>(
                    value: selectedPriority,
                    decoration: FormValidators.createOptionalInputDecoration(
                      labelText: AppLocalizations.of(context)!.priority,
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
                          color: AppTheme.primaryColor,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      suffixText: null, // Remove character counter for dropdown
                    ),
                    items: Priority.values
                        .map(
                          (priority) => DropdownMenuItem(
                            value: priority,
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(priority),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(_getPriorityDisplayName(priority)),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedPriority = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: selectedDueDate ?? DateTime.now(),
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 365),
                        ),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: Theme.of(context).colorScheme
                                  .copyWith(primary: AppTheme.primaryColor),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (date != null) {
                        setState(() {
                          selectedDueDate = date;
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
                            color: AppTheme.primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            selectedDueDate == null
                                ? AppLocalizations.of(
                                    context,
                                  )!.setDueDateOptional
                                : AppLocalizations.of(context)!.dueWithDate(
                                    selectedDueDate!.day,
                                    selectedDueDate!.month,
                                    selectedDueDate!.year,
                                  ),
                            style: TextStyle(
                              color: selectedDueDate == null
                                  ? AppTheme.textSecondary
                                  : Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                            ),
                          ),
                          const Spacer(),
                          if (selectedDueDate != null)
                            IconButton(
                              icon: Icon(
                                Iconsax.close_circle,
                                color: AppTheme.textSecondary,
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedDueDate = null;
                                });
                              },
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
                              // Validate fields before saving
                              final titleValidation =
                                  FormValidators.validateTitle(
                                    titleController.text,
                                    context,
                                  );
                              final descriptionValidation =
                                  FormValidators.validateDescription(
                                    descriptionController.text,
                                    context,
                                  );

                              setState(() {
                                titleError = titleValidation;
                                descriptionError = descriptionValidation;
                              });

                              if (titleValidation != null ||
                                  descriptionValidation != null) {
                                return; // Don't save if there are validation errors
                              }

                              final todoItem = TodoItem(
                                id: widget.todo?.id ?? const Uuid().v4(),
                                tripId: widget.tripId,
                                title: titleController.text.trim(),
                                description: descriptionController.text.trim(),
                                isCompleted: widget.todo?.isCompleted ?? false,
                                priority: selectedPriority,
                                dueDate: selectedDueDate,
                                assignedTo: widget.todo?.assignedTo ?? '',
                                tags: widget.todo?.tags ?? [],
                                createdAt: widget.todo?.createdAt ?? DateTime.now(),
                                updatedAt: DateTime.now(),
                              );

                              try {
                                if (isEdit) {
                                  await Provider.of<TodoProvider>(
                                    context,
                                    listen: false,
                                  ).updateTodo(todoItem);
                                } else {
                                  await Provider.of<TodoProvider>(
                                    context,
                                    listen: false,
                                  ).createTodo(todoItem);
                                }
                                if (!context.mounted) return;
                                Navigator.pop(context);
                              } catch (e) {
                                if (!context.mounted) return;
                                showAppSnackBar(
                                  context,
                                  AppLocalizations.of(context)!.failedToAddUpdateTask(
                                    isEdit ? 'update' : 'add',
                                    e.toString(),
                                  ),
                                  type: SnackBarType.error,
                                );
                              }
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
                              isEdit
                                  ? AppLocalizations.of(context)!.updateTask
                                  : AppLocalizations.of(context)!.addTask,
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
        ],
      ),
      ),
      ),
    );
  }

  Color _getPriorityColor(Priority priority) {
    final color = AppTheme.priorityColors[priority.index];
    switch (priority) {
      case Priority.urgent:
        return color;
      case Priority.high:
        return color;
      case Priority.medium:
        return color;
      case Priority.low:
        return color;
    }
  }

  String _getPriorityDisplayName(Priority priority) {
    final l10n = AppLocalizations.of(context)!;
    switch (priority) {
      case Priority.urgent:
        return l10n.urgent;
      case Priority.high:
        return l10n.high;
      case Priority.medium:
        return l10n.medium;
      case Priority.low:
        return l10n.low;
    }
  }
}
