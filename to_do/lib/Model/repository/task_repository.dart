import 'package:sqflite/sqflite.dart';
import 'package:to_do/Model/database/database.dart';
import 'package:to_do/Model/models/task_model.dart';

class TaskRepository {
  TaskRepository._privateConstructor();

  static final TaskRepository instance = TaskRepository._privateConstructor();

  final String table = 'task';

  Future<bool> addTask(TaskModel task) async {
    Database db = await AppDatabase.instance.database;
    try {
      db.rawInsert('''
INSERT INTO task (
                     user_id,
                     category_id,
                     title,
                     description,
                     date,
                     priority,
                     is_done
                 )
                 VALUES (
                     ${task.userId},
                     ${task.categoryId},
                     '${task.title}',
                     '${task.description}',
                     '${task.date}',
                     ${task.priority},
                     0
                 )
    ''');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<TaskModel> fetchLastTaskAfterAdding() async {
    Database db = await AppDatabase.instance.database;
    var res = await db.rawQuery('''
    SELECT * FROM $table ORDER BY id DESC LIMIT 1; 
        ''');
    return TaskModel.fromJson(res[0]);
  }

  Future<List<TaskModel>> fetchTasks(int userId) async {
    Database db = await AppDatabase.instance.database;
    var res = await db.rawQuery('''
    SELECT * FROM $table
        ''');
    return List.generate(res.length, (index) => TaskModel.fromJson(res[index]));
  }

  Future<bool> removeTask(int id) async {
    Database db = await AppDatabase.instance.database;
    try {
      await db.rawDelete('''DELETE FROM $table WHERE ID = '$id' ''');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> completeTask(int id) async {
    Database db = await AppDatabase.instance.database;
    try {
      await db.rawUpdate('''
      UPDATE task
        SET 
            is_done = '1'
      WHERE id = '$id';
      ''');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> undoneTask(int id) async {
    Database db = await AppDatabase.instance.database;
    try {
      await db.rawUpdate('''
      UPDATE task
        SET 
            is_done = '0'
      WHERE id = '$id';
      ''');
      return true;
    } catch (e) {
      return false;
    }
  }

// Updates Related Functions

  // Update category_id
  Future<bool> updateCategoryId(int taskId, int categoryId) async {
    Database db = await AppDatabase.instance.database;
    int result = await db.rawUpdate(
      'UPDATE task SET category_id = ? WHERE id = ?',
      [categoryId, taskId],
    );
    return result > 0;
  }

  // Update title
  Future<bool> updateTitle(int taskId, String title) async {
    Database db = await AppDatabase.instance.database;
    int result = await db.rawUpdate(
      'UPDATE task SET title = ? WHERE id = ?',
      [title, taskId],
    );
    return result > 0;
  }

  // Update description
  Future<bool> updateDescription(int taskId, String description) async {
    Database db = await AppDatabase.instance.database;
    int result = await db.rawUpdate(
      'UPDATE task SET description = ? WHERE id = ?',
      [description, taskId],
    );
    return result > 0;
  }

  // Update date
  Future<bool> updateDate(int taskId, String date) async {
    Database db = await AppDatabase.instance.database;
    int result = await db.rawUpdate(
      'UPDATE task SET date = ? WHERE id = ?',
      [date, taskId],
    );
    return result > 0;
  }

  // Update priority
  Future<bool> updatePriority(int taskId, int priority) async {
    Database db = await AppDatabase.instance.database;
    int result = await db.rawUpdate(
      'UPDATE task SET priority = ? WHERE id = ?',
      [priority, taskId],
    );
    return result > 0;
  }
}
