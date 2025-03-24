import 'package:to_do/Model/models/category_model.dart';
import 'package:to_do/Model/repository/category_repository.dart';

class In_Memory_Categories {
  In_Memory_Categories._private();

  static In_Memory_Categories instance = In_Memory_Categories._private();

  Map<int, CategoryModel> categories = {};

  void loadCategories() async {
    var fetchedCategories = await CategoryRepository.instance.fetchCategories();
    for (var element in fetchedCategories) {
      categories[element.id] = element;
    }
  }

  void addCategories(CategoryModel category) {
    categories[category.id] = category;
  }

  String categoryName(int id) {
    return categories[id]!.name;
  }

  CategoryModel category(int id) {
    return categories[id]!;
  }
}
