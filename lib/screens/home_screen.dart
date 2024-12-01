import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final totalTasks = taskProvider.tasks.length;
    final completedTasks = taskProvider.tasks.where((task) => task.isCompleted).length;
    final lowPriorityTasks = taskProvider.tasks.where((task) => task.priority == 'Low').length;
    final normalPriorityTasks = taskProvider.tasks.where((task) => task.priority == 'Normal').length;
    final highPriorityTasks = taskProvider.tasks.where((task) => task.priority == 'High').length;

    final completionPercentage = totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.task_alt,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'Task Manager',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 5.0,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Organize your tasks efficiently',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Completed Tasks: ${completionPercentage.toStringAsFixed(1)}%',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: completionPercentage / 100,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ),
            const SizedBox(height: 40),
            Text(
              'Priority Breakdown:',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Low: $lowPriorityTasks | Normal: $normalPriorityTasks | High: $highPriorityTasks',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/add-task');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                minimumSize: const Size(180, 55),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 10,
              ),
              icon: Icon(Icons.add, color: Colors.blue.shade900),
              label: Text(
                'Add New Task',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/list-tasks');
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                minimumSize: const Size(180, 55),
                side: const BorderSide(color: Colors.white, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.list_alt, color: Colors.white),
              label: const Text(
                'View Tasks',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                minimumSize: const Size(180, 55),
                side: const BorderSide(color: Colors.white, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.settings, color: Colors.white),
              label: const Text(
                'Settings',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
