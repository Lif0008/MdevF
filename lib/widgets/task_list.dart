import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return ListView.builder(
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, index) {
            final task = taskProvider.tasks[index];
            return ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  fontSize: 18,
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing: Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  taskProvider.toggleTaskCompletion(task.id);
                },
              ),
            );
          },
        );
      },
    );
  }
}
