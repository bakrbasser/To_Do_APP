import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Model/models/category_model.dart';
import 'package:to_do/Model/repository/category_repository.dart';
import 'package:to_do/Model_View/storage/added_category.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  CategoryRepository repository = CategoryRepository.instance;
  Future fetchCategories() async {
    var res = await repository.fetchCategories();
    if (res.isEmpty) {
      emit(EmptyCategories());
    } else {
      emit(FetchedCategories(categories: res));
    }
  }

  Future addCategory() async {
    if (In_Memory_Category.category != null) {
      await repository.addCategory(In_Memory_Category.category!);
      emit(AddedSuccessfully());
    } else {
      emit(AddingFailed());
    }
  }
}
