import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static const _databaseName = "todo_app.db";
  static const _databaseVersion = 1;

  AppDatabase._privateConstructor();
  static final AppDatabase instance = AppDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    user_name TEXT    NOT NULL
                      UNIQUE,
    password  TEXT    NOT NULL
)
''');
  }

  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database db = await database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await database;
    return await db.rawQuery('SELECT * FROM $table');
  }

  Future<Map<String, dynamic>> getInstance(String table, int id) async {
    Database db = await database;
    var res = await db.rawQuery('Select * From $table where id = $id');
    return res[0];
  }



  Future close() async {
    Database db = await database;
    db.close();
  }
}
