import 'package:sqflite/sqflite.dart';
import 'package:to_do/Model/database/database.dart';
import 'package:to_do/Model/models/category_model.dart';
import 'package:to_do/Model_View/storage/in_memory_categories.dart';

class CategoryRepository {
  CategoryRepository._privateConstructor();

  static final CategoryRepository instance =
      CategoryRepository._privateConstructor();

  final String table = 'category';

  Future<bool> addCategory(CategoryModel category) async {
    try {
      var db = await AppDatabase.instance.database;
      db.rawInsert('''
INSERT INTO category (
                         
                         name,
                         color
                     )
                     VALUES (
                         
                         '${category.name}',
                         '${category.color}'
                     );
''');
      In_Memory_Categories.instance.addCategories(await fetchLastCategory());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    Database db = await AppDatabase.instance.database;
    var res = await db.rawQuery('SELECT * FROM $table');
    return List.generate(
        res.length, (index) => CategoryModel.fromJson(res[index]));
  }

  Future<bool> removeCategory(int id) async {
    Database db = await AppDatabase.instance.database;
    try {
      await db.rawDelete('''DELETE FROM $table WHERE ID = '$id' ''');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<CategoryModel> fetchLastCategory() async {
    Database db = await AppDatabase.instance.database;
    var res =
        await db.rawQuery('SELECT * FROM category ORDER BY id DESC LIMIT 1;');
    return CategoryModel.fromJson(res[0]);
  }
}
