import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_task_screen.dart'; 
import 'screens/list_task_screen.dart'; 
import 'screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return MaterialApp(
            title: 'Task Manager',
            theme: ThemeData(
              brightness: taskProvider.isDarkMode ? Brightness.dark : Brightness.light,
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => HomeScreen(),
              '/add-task': (context) => AddTaskScreen(),
              '/list-tasks': (context) => ListTaskScreen(),
              '/settings': (context) => SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}
