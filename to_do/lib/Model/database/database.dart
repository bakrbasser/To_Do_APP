import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static const _databaseName = "todo_app.db";
  static const _databaseVersion = 4;

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
        version: _databaseVersion, onCreate: _createDB, onUpgrade: _upgradeDB);
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

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (_databaseVersion == 3) {
      await db.execute('''
      CREATE TABLE category (
    id    INTEGER PRIMARY KEY AUTOINCREMENT,
    name  TEXT    UNIQUE
                  NOT NULL,
    color TEXT
);

''');
    }
    if (_databaseVersion == 4) {
      await db.execute('''CREATE TABLE task (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id     INTEGER REFERENCES user (id) 
                        NOT NULL,
    category_id INTEGER REFERENCES category (id) 
                        NOT NULL,
    title       TEXT    NOT NULL,
    description,
    date        TEXT    NOT NULL,
    priority    INTEGER DEFAULT (1) 
);
''');
    }
  }

  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database db = await database;
    return await db.rawInsert('''INSERT INTO user (
                     
                     user_name,
                     password
                 )
                 VALUES (
                     '${row['user_name']}',
                     '${row['password']}'
                 );
''');
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
