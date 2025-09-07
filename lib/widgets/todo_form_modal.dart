import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_item.dart';
import '../themes/app_theme.dart';
import '../providers/todo_provider.dart';

class TodoFormModal extends StatelessWidget {
  final String tripId;
  final TodoItem? todo;

  const TodoFormModal({
    super.key,
    required this.tripId,
    this.todo,
  });

  static void show(BuildContext context, String tripId, {TodoItem? todo}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => TodoFormModal(
        tripId: tripId,
        todo: todo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = todo != null;
    final titleController = TextEditingController(text: todo?.title ?? '');
    final descriptionController = TextEditingController(text: todo?.description ?? '');
    Priority selectedPriority = todo?.priority ?? Priority.medium;
    DateTime? selectedDueDate = todo?.dueDate;

    return StatefulBuilder(
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
                            Iconsax.task_square,
                            color: AppTheme.primaryColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          isEdit ? 'Edit Task' : 'Add New Task',
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
                        labelText: 'Task Title',
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
                    DropdownButtonFormField<Priority>(
                      value: selectedPriority,
                      decoration: InputDecoration(
                        labelText: 'Priority',
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
                      items: Priority.values
                          .map((priority) => DropdownMenuItem(
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
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setModalState(() {
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
                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
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
                        if (date != null) {
                          setModalState(() {
                            selectedDueDate = date;
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
                              color: AppTheme.primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              selectedDueDate == null
                                  ? 'Set Due Date (Optional)'
                                  : 'Due: ${selectedDueDate!.day}/${selectedDueDate!.month}/${selectedDueDate!.year}',
                              style: TextStyle(
                                color: selectedDueDate == null 
                                  ? AppTheme.textSecondary 
                                  : Theme.of(context).textTheme.bodyMedium?.color,
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
                                  setModalState(() {
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
                              onPressed: () async {
                                if (titleController.text.trim().isEmpty) return;

                                final todoItem = TodoItem(
                                  id: todo?.id ?? const Uuid().v4(),
                                  tripId: tripId,
                                  title: titleController.text.trim(),
                                  description: descriptionController.text.trim(),
                                  isCompleted: todo?.isCompleted ?? false,
                                  priority: selectedPriority,
                                  dueDate: selectedDueDate,
                                  assignedTo: todo?.assignedTo ?? '',
                                  tags: todo?.tags ?? [],
                                  createdAt: todo?.createdAt ?? DateTime.now(),
                                  updatedAt: DateTime.now(),
                                );

                                try {
                                  if (isEdit) {
                                    await Provider.of<TodoProvider>(context, listen: false)
                                        .updateTodo(todoItem);
                                  } else {
                                    await Provider.of<TodoProvider>(context, listen: false)
                                        .addTodo(todoItem);
                                  }
                                  Navigator.pop(context);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Failed to ${isEdit ? 'update' : 'add'} task: $e'),
                                      backgroundColor: AppTheme.error,
                                    ),
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
                                isEdit ? 'Update Task' : 'Add Task',
                                style: const TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
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
    );
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.urgent:
        return AppTheme.error;
      case Priority.high:
        return AppTheme.warning;
      case Priority.medium:
        return AppTheme.accentColor;
      case Priority.low:
        return AppTheme.success;
    }
  }

  String _getPriorityDisplayName(Priority priority) {
    switch (priority) {
      case Priority.urgent:
        return 'Urgent';
      case Priority.high:
        return 'High';
      case Priority.medium:
        return 'Medium';
      case Priority.low:
        return 'Low';
    }
  }
}