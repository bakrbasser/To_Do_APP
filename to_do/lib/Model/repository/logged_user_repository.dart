import 'package:sqflite/sqflite.dart';
import 'package:to_do/Model/database/database.dart';

class LoggedUserRepository {
  LoggedUserRepository._privaterConstruct();

  static final LoggedUserRepository instance =
      LoggedUserRepository._privaterConstruct();

  final String table = 'logged_user';

  Future<int> lastLoggedUserId() async {
    Database db = await AppDatabase.instance.database;
    List<Map<String, dynamic>> res = await db.rawQuery('''
SELECT * FROM $table
''');
    if (res.isNotEmpty) {
      return res[0]['id'];
    } else {
      return -1;
    }
  }

  Future<void> logout() async {
    Database db = await AppDatabase.instance.database;
    await db.rawDelete('DELETE FROM $table');
  }

  Future<void> login(int userId) async {
    await logout();
    Database db = await AppDatabase.instance.database;
    await db.rawInsert('''
  INSERT INTO logged_user (
                            id
                        )
                        VALUES (
                            '$userId'
                        );
''');
  }
}
