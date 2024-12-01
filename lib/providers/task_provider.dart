import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  bool _isDarkMode = false;
  double _fontSize = 16.0; // Default font size

  List<Task> get tasks => _tasks;
  bool get isDarkMode => _isDarkMode;
  double get fontSize => _fontSize;

  // Add a new task with description and priority
  void addTask({
    required String title,
    required String description,
    String priority = 'Normal',
    DateTime? dueDate,
  }) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      priority: priority,
      createdAt: DateTime.now(),
      dueDate: dueDate,
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  // Toggle task completion status
  void toggleTaskCompletion(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = _tasks[taskIndex].copyWith(
        isCompleted: !_tasks[taskIndex].isCompleted,
      );
      notifyListeners();
    }
  }

  // Remove a task by ID
  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  // Toggle dark mode
  void toggleDarkMode(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }

  // Update font size
  void updateFontSize(double newSize) {
    _fontSize = newSize;
    notifyListeners();
  }

  // Sort tasks based on a given criteria
  void sortTasks(String sortBy) {
    switch (sortBy) {
      case 'Date Created':
        _tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case 'Due Date':
        _tasks.sort((a, b) => (a.dueDate ?? DateTime.now()).compareTo(b.dueDate ?? DateTime.now()));
        break;
      case 'Priority':
        _tasks.sort((a, b) => _priorityRank(a.priority).compareTo(_priorityRank(b.priority)));
        break;
      case 'Name':
      default:
        _tasks.sort((a, b) => a.title.compareTo(b.title));
    }
    notifyListeners();
  }

  // Helper function for priority ranking
  int _priorityRank(String priority) {
    switch (priority) {
      case 'High':
        return 1;
      case 'Normal':
        return 2;
      case 'Low':
        return 3;
      default:
        return 4;
    }
  }

  // Remove all completed tasks
  void removeCompletedTasks() {
    _tasks.removeWhere((task) => task.isCompleted);
    notifyListeners();
  }
}
