import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../models/trip.dart';
import '../../models/todo_item.dart';
import '../../themes/app_theme.dart';
import '../../providers/todo_provider.dart';
import 'package:uuid/uuid.dart';

class TodoTab extends StatefulWidget {
  final Trip trip;

  const TodoTab({super.key, required this.trip});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  Priority? _selectedPriority; // null means 'all'

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false).loadTodos(widget.trip.id);
    });
  }

  List<TodoItem> _getFilteredAndSortedTodos(List<TodoItem> todos) {
    List<TodoItem> filtered;
    if (_selectedPriority == null) {
      filtered = todos;
    } else {
      filtered = todos.where((todo) => todo.priority == _selectedPriority).toList();
    }
    
    filtered.sort((a, b) {
      // Sort by completion status first (incomplete first)
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      // Then by priority (highest first)
      final priorityOrder = [
        Priority.urgent,
        Priority.high,
        Priority.medium,
        Priority.low,
      ];
      final aIndex = priorityOrder.indexOf(a.priority);
      final bIndex = priorityOrder.indexOf(b.priority);
      if (aIndex != bIndex) {
        return aIndex.compareTo(bIndex);
      }
      // Finally by due date
      if (a.dueDate != null && b.dueDate != null) {
        return a.dueDate!.compareTo(b.dueDate!);
      } else if (a.dueDate != null) {
        return -1;
      } else if (b.dueDate != null) {
        return 1;
      }
      return 0;
    });
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        if (todoProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          );
        }

        if (todoProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.warning_2,
                  size: 48,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load todos',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  todoProvider.error!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => todoProvider.loadTodos(widget.trip.id),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final sortedTodos = _getFilteredAndSortedTodos(todoProvider.todos);

        return Scaffold(
          body: Column(
            children: [
              _buildFilterBar(todoProvider.todos),
              Expanded(
                child: todoProvider.todos.isEmpty
                    ? _buildEmptyState()
                    : RefreshIndicator(
                        onRefresh: () => todoProvider.loadTodos(widget.trip.id),
                        color: AppTheme.primaryColor,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: sortedTodos.length,
                          itemBuilder: (context, index) {
                            return _buildTodoItem(sortedTodos[index]);
                          },
                        ),
                      ),
              ),
            ],
          ),
          floatingActionButton: Container(
            decoration: AppTheme.glowingButtonDecoration,
            child: FloatingActionButton.extended(
              onPressed: _showAddTodoDialog,
              icon: const Icon(Iconsax.add),
              label: const Text(
                'Task',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterBar(List<TodoItem> todos) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Add 'All' filter chip
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text('All (${todos.length})'),
                      selected: _selectedPriority == null,
                      onSelected: (selected) {
                        setState(() {
                          _selectedPriority = null;
                        });
                      },
                      selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                      checkmarkColor: AppTheme.primaryColor,
                      labelStyle: TextStyle(
                        color: _selectedPriority == null ? AppTheme.primaryColor : null,
                        fontWeight: _selectedPriority == null ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                  // Add priority filter chips
                  ...Priority.values.map((priority) {
                    final isSelected = _selectedPriority == priority;
                    final priorityColor = _getPriorityColor(priority);
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(
                          '${_getPriorityDisplayName(priority)} (${todos.where((t) => t.priority == priority).length})',
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedPriority = selected ? priority : null;
                          });
                        },
                        selectedColor: priorityColor.withOpacity(0.2),
                        checkmarkColor: priorityColor,
                        labelStyle: TextStyle(
                          color: isSelected ? priorityColor : null,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
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
                Iconsax.task_square,
                size: 48,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No To-Do Items',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Stay organized by adding tasks for your trip planning!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: AppTheme.glowingButtonDecoration,
              child: ElevatedButton.icon(
                onPressed: _showAddTodoDialog,
                icon: const Icon(Iconsax.add),
                label: const Text(
                  'Add First Task',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoItem(TodoItem todo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.surfaceDark
            : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getPriorityColor(todo.priority).withOpacity(0.3),
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
        onTap: () => _showTodoDetailsBottomSheet(todo),
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (value) async {
            final updatedTodo = todo.copyWith(
              isCompleted: value ?? false,
              updatedAt: DateTime.now(),
            );
            await Provider.of<TodoProvider>(context, listen: false).updateTodo(updatedTodo);
          },
          activeColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted ? AppTheme.textSecondary : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(todo.priority).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _getPriorityColor(todo.priority).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  _getPriorityDisplayName(todo.priority),
                  style: TextStyle(
                    color: _getPriorityColor(todo.priority),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (todo.dueDate != null) ...[
                const SizedBox(width: 8),
                Icon(
                  Iconsax.calendar_1,
                  size: 14,
                  color: _getDueDateColor(todo.dueDate!),
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDueDate(todo.dueDate!),
                  style: TextStyle(
                    fontSize: 12,
                    color: _getDueDateColor(todo.dueDate!),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showTodoDetailsBottomSheet(TodoItem todo) {
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
                              color: AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Iconsax.task_square,
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
                                  'Task Details',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  todo.isCompleted ? 'Completed' : 'Pending',
                                  style: TextStyle(
                                    color: todo.isCompleted ? Colors.green : AppTheme.primaryColor,
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
                        todo.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      if (todo.description.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          todo.description,
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            height: 1.4,
                          ),
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
                                  'Priority',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(todo.priority).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _getPriorityColor(todo.priority).withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    _getPriorityDisplayName(todo.priority),
                                    style: TextStyle(
                                      color: _getPriorityColor(todo.priority),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (todo.dueDate != null) ...[
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Due Date',
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Iconsax.calendar_1,
                                        size: 16,
                                        color: _getDueDateColor(todo.dueDate!),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '${todo.dueDate!.day}/${todo.dueDate!.month}/${todo.dueDate!.year}',
                                        style: TextStyle(
                                          color: _getDueDateColor(todo.dueDate!),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _formatDueDate(todo.dueDate!),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getDueDateColor(todo.dueDate!),
                                      fontWeight: FontWeight.w500,
                                    ),
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
                                _showEditTodoDialog(todo);
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
                              onPressed: () async {
                                Navigator.pop(context);
                                await Provider.of<TodoProvider>(context, listen: false).deleteTodo(todo.id);
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

  Color _getPriorityColor(Priority priority) {
    final priorityColors = AppTheme.priorityColors;
    switch (priority) {
      case Priority.urgent:
        return priorityColors[3]; // Red
      case Priority.high:
        return priorityColors[2]; // Orange
      case Priority.medium:
        return priorityColors[1]; // Yellow
      case Priority.low:
        return priorityColors[0]; // Green
    }
  }

  Color _getDueDateColor(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;

    if (difference < 0) {
      return AppTheme.error; // Overdue
    } else if (difference <= 1) {
      return Colors.orange; // Due soon
    } else {
      return AppTheme.textSecondary; // Normal
    }
  }

  String _formatDueDate(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;

    if (difference < 0) {
      return 'Overdue';
    } else if (difference == 0) {
      return 'Due today';
    } else if (difference == 1) {
      return 'Due tomorrow';
    } else {
      return 'Due in $difference days';
    }
  }

  void _showAddTodoDialog() {
    _showTodoDialog();
  }

  void _showEditTodoDialog(TodoItem todo) {
    _showTodoDialog(todo: todo);
  }

  void _showTodoDialog({TodoItem? todo}) {
    final isEdit = todo != null;
    final titleController = TextEditingController(text: todo?.title ?? '');
    final descriptionController = TextEditingController(text: todo?.description ?? '');
    Priority selectedPriority = todo?.priority ?? Priority.medium;
    DateTime? selectedDueDate = todo?.dueDate;

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
                                    tripId: widget.trip.id,
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

                                  if (isEdit) {
                                    await Provider.of<TodoProvider>(context, listen: false).updateTodo(todoItem);
                                  } else {
                                    await Provider.of<TodoProvider>(context, listen: false).createTodo(todoItem);
                                  }
                                  
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
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
                                  isEdit ? 'Update Task' : 'Add Task',
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
}

