import 'package:to_do/Model/models/category_model.dart';

// ignore: camel_case_types
class In_Memory_Category {
  static String name = '';
  static String color = '';

  static CategoryModel? get category {
    if (name.isEmpty || color.isEmpty) {
      return null;
    } else {
      return CategoryModel(id: 0, name: name, color: color);
    }
  }

  static reset() {
    name = '';
    color = '';
  }
}
