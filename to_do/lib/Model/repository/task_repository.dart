import 'package:sqflite/sqflite.dart';
import 'package:to_do/Model/database/database.dart';
import 'package:to_do/Model/models/task_model.dart';

class TaskRepository {
  TaskRepository._privateConstructor();

  static final TaskRepository instance = TaskRepository._privateConstructor();

  final String table = 'task';

  Future<bool> addTask(TaskModel task) async {
    try {
      await AppDatabase.instance.insert(task.toRow(), table);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<TaskModel>> fetchTasks(int id) async {
    Database db = await AppDatabase.instance.database;
    var res = await db.rawQuery('''SELECT * FROM $table where id = '$id' ''');
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

  Future<bool> updateTask(TaskModel task) async {
    Database db = await AppDatabase.instance.database;

    int result = await db.rawUpdate(
      '''
    UPDATE task 
    SET 
      category_id = ?, 
      title = ?, 
      description = ?, 
      date = ?, 
      priority = ?
    WHERE id = ?
    ''',
      [
        task.categoryId,
        task.title,
        task.description,
        task.date,
        task.priority,
        task.id
      ],
    );

    return result > 0; // Returns true if at least one row was updated
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
}
