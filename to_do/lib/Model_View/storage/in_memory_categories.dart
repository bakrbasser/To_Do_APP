import 'package:to_do/Model/models/category_model.dart';
import 'package:to_do/Model/repository/category_repository.dart';

class InMemoryCategories {
  InMemoryCategories._private();

  static InMemoryCategories instance = InMemoryCategories._private();

  List<CategoryModel> categories = [];

  void loadCategories() async {
    var fetchedCategories = await CategoryRepository.instance.fetchCategories();
    categories = fetchedCategories;
  }
}
