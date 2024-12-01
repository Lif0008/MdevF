class Task {
  final String id;
  final String title;
  final String description;  
  final bool isCompleted;
  final String priority;
  final DateTime createdAt;
  final DateTime? dueDate;

  Task({
    required this.id,
    required this.title,
    required this.description, 
    this.isCompleted = false,
    this.priority = 'Normal',
    required this.createdAt,
    this.dueDate,
  });

  // copyWith method
  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? priority,
    DateTime? createdAt,
    DateTime? dueDate,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
