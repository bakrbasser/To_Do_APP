import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Model/models/category_model.dart';
import 'package:to_do/Model/repository/category_repository.dart';
import 'package:to_do/Model_View/storage/added_category.dart';
import 'package:to_do/Model_View/storage/in_memory_categories.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  CategoryRepository repository = CategoryRepository.instance;

  List<CategoryModel> categories =
      In_Memory_Categories.instance.categories.values.toList();
  Future fetchCategories() async {
    categories = await repository.fetchCategories();
    if (categories.isEmpty) {
      emit(EmptyCategories());
    } else {
      emit(FetchedCategories(categories: categories));
    }
  }

  Future addCategory() async {
    if (In_Memory_Category.category != null) {
      if (await repository.addCategory(In_Memory_Category.category!)) {
        categories.add(await fetchLastCategory());
        emit(AddedSuccessfully(categories: categories));
      } else {
        emit(AddingFailed());
      }
    }
  }

  Future<CategoryModel> fetchLastCategory() async {
    return await repository.fetchLastCategory();
  }
}
