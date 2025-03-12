import 'package:to_do/Model/models/task_model.dart';

// ignore: camel_case_types
class In_Memory_Task {
  static int? userId;
  static int? categoryId;
  static String? title;
  static String? description;
  static String? date;
  static int? priority;

  static TaskModel? get task {
    if (userId == null || categoryId == null || title == null || date == null) {
      return null;
    }

    return TaskModel(
        userId: userId!,
        categoryId: categoryId!,
        title: title!,
        description: description!, // Ensure TaskModel supports this
        date: date!,
        priority: priority, // Ensure TaskModel supports this
        isDone: 0);
  }

  static void reset() {
    userId = null;
    categoryId = null;
    title = null;
    description = null;
    date = null;
    priority = null;
  }
}
