import 'package:to_do/Model/models/task_model.dart';

//This task is going to be used for creating new tasks and updating existing ones

// ignore: camel_case_types
class Cached_Task_For_Adding_Fields {
  static int? userId;
  static int? categoryId;
  static String? title;
  static String? description;
  static String? date;
  static int? priority;

  static TaskModel? get cachedTask {
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

// ignore: camel_case_types
class Cached_Task_For_Updating {
  Cached_Task_For_Updating._priv();

  static Cached_Task_For_Updating instance = Cached_Task_For_Updating._priv();

  late TaskModel task;

  late int index;
}
