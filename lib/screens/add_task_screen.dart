// screens/add_task_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; 
import '../providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _priority = 'Normal';
  DateTime? _dueDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: _priority,
              items: ['Low', 'Normal', 'High'].map((String priority) {
                return DropdownMenuItem(
                  value: priority,
                  child: Text(priority),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _priority = newValue;
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                _dueDate == null
                    ? 'Select Due Date'
                    : 'Due Date: ${DateFormat('yyyy-MM-dd').format(_dueDate!)}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dueDate = pickedDate; 
                  });
                }
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  Provider.of<TaskProvider>(context, listen: false).addTask(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    priority: _priority,
                    dueDate: _dueDate,
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text('Add Task', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
