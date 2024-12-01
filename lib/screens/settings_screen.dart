import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final double currentFontSize = taskProvider.fontSize;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.grey),
            ListTile(
              title: const Text('Clear Completed Tasks', style: TextStyle(fontSize: 18)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Clear Completed Tasks'),
                      content: const Text('Are you sure you want to delete all completed tasks?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            taskProvider.removeCompletedTasks();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Clear'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Font Size',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.grey),
            ListTile(
              title: const Text('Adjust Font Size', style: TextStyle(fontSize: 18)),
              subtitle: Text('Current Font Size: ${currentFontSize.toStringAsFixed(1)}'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    double tempFontSize = currentFontSize;
                    return AlertDialog(
                      title: const Text('Adjust Font Size'),
                      content: StatefulBuilder(
                        builder: (context, setState) {
                          return Slider(
                            value: tempFontSize,
                            min: 10.0,
                            max: 30.0,
                            divisions: 20,
                            label: tempFontSize.toStringAsFixed(1),
                            onChanged: (double newValue) {
                              setState(() {
                                tempFontSize = newValue;
                              });
                            },
                          );
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            taskProvider.updateFontSize(tempFontSize); // Pass updated value
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
