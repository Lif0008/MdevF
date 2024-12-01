import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/task_provider.dart';

class ListTaskScreen extends StatelessWidget {
  const ListTaskScreen({super.key});

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Normal':
        return Colors.blue;
      case 'Low':
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          // Popup Menu for sorting tasks
          PopupMenuButton<String>(
            onSelected: (value) {
              // Sorting the tasks based on the selected option
              Provider.of<TaskProvider>(context, listen: false).sortTasks(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Name', child: Text('Sort by Name')),
              const PopupMenuItem(value: 'Date Created', child: Text('Sort by Date Created')),
              const PopupMenuItem(value: 'Due Date', child: Text('Sort by Due Date')),
              const PopupMenuItem(value: 'Priority', child: Text('Sort by Priority')),
            ],
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: taskProvider.fontSize, // Dynamic font size
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.isCompleted ? Colors.grey : Colors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.description,
                        style: TextStyle(fontSize: taskProvider.fontSize), // Dynamic font size
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Created: ${DateFormat('yyyy-MM-dd').format(task.createdAt)}',
                        style: TextStyle(
                          fontSize: taskProvider.fontSize * 0.9,
                          color: Colors.grey[700],
                        ),
                      ),
                      if (task.dueDate != null) ...[
                        Text(
                          'Due: ${DateFormat('yyyy-MM-dd').format(task.dueDate!)}',
                          style: TextStyle(
                            fontSize: taskProvider.fontSize * 0.9,
                            color: Colors.grey[700],
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Due: Not Set',
                          style: TextStyle(
                            fontSize: taskProvider.fontSize * 0.9,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          // Show confirmation dialog before deleting the task
                          bool? confirmDelete = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Task'),
                                content: const Text('Are you sure you want to delete this task?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false), 
                                    child: const Text('Cancel')
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true), 
                                    child: const Text('Delete')
                                  ),
                                ],
                              );
                            },
                          );

                          // If confirmed, call removeTask
                          if (confirmDelete == true) {
                            Provider.of<TaskProvider>(context, listen: false).removeTask(task.id);
                          }
                        },
                      ),
                      Checkbox(
                        value: task.isCompleted,
                        onChanged: (bool? newValue) {
                          Provider.of<TaskProvider>(context, listen: false)
                              .toggleTaskCompletion(task.id);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Provider.of<TaskProvider>(context, listen: false)
                        .toggleTaskCompletion(task.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
