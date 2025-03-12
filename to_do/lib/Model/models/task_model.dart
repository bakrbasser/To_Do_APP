class TaskModel {
  final int? id;
  final int userId;
  final int categoryId;
  final String title;
  final String? description;
  final String date;
  final int? priority;
  final int isDone;

  TaskModel(
      {this.id,
      required this.userId,
      required this.categoryId,
      required this.title,
      this.description,
      required this.date,
      this.priority = 1,
      required this.isDone});

  // Factory constructor to create a Task object from a JSON map
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int,
      categoryId: json['category_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      date: json['date'] as String,
      priority: json['priority'] as int? ?? 1, // Default value if null
      isDone: json['is_done'],
    );
  }

  factory TaskModel.empty() {
    return TaskModel(userId: 0, categoryId: 0, title: '', date: '', isDone: 0);
  }

  // Converts the Task object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'category_id': categoryId,
      'title': title,
      'description': description,
      'date': date,
      'priority': priority,
      'is_done': isDone,
    };
  }

  Map<String, dynamic> toRow() {
    return {
      'user_id': userId,
      'category_id': categoryId,
      'title': title,
      'description': description,
      'date': date,
      'priority': priority,
    };
  }
}
