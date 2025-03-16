import 'package:sqflite/sqflite.dart';
import 'package:to_do/Model/database/database.dart';
import 'package:to_do/Model/models/user_model.dart';

class UserRepository {
  UserRepository._privaterConstruct();

  static final UserRepository instance = UserRepository._privaterConstruct();

  final String table = 'user';

  Future<bool> addUser(UserModel user) async {
    try {
      await AppDatabase.instance.insertUser(user.toRow(), table);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> checkUser(UserModel user) async {
    Database db = await AppDatabase.instance.database;
    List<Map<String, dynamic>> res = await db.rawQuery(
        'Select id from user where password = \'${user.password}\' and user_name = \'${user.username}\' ');
    if (res.isNotEmpty) {
      return res[0]['id'];
    } else {
      return -1;
    }
  }
}
