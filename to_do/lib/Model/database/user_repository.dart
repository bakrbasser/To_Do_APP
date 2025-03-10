import 'package:sqflite/sqflite.dart';
import 'package:to_do/Model/database/database.dart';
import 'package:to_do/Model/models/user_model.dart';

class UserRepository {
  UserRepository._privaterConstruct();

  static final UserRepository instance = UserRepository._privaterConstruct();

  final String table = 'user';

  Future<bool> addUser(UserModel user) async {
    var result = await AppDatabase.instance.insert(user.toRow(), table);
    if (result == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkUser(UserModel user) async {
    Database db = await AppDatabase.instance.database;
    var res = await db.rawQuery(
        'Select * from user where password = ${user.password} and username = ${user.username} ');
    return res.isNotEmpty;
  }
}
