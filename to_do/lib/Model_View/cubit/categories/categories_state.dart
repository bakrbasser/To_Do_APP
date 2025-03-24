part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

class CategoryStateWithList extends CategoriesState {
  final List<CategoryModel> categories;

  CategoryStateWithList({required this.categories});
}

class FetchedCategories extends CategoryStateWithList {
  FetchedCategories({required super.categories});
}

class AddedSuccessfully extends CategoryStateWithList {
  AddedSuccessfully({required super.categories});
}

class EmptyCategories extends CategoriesState {}

class AddingFailed extends CategoriesState {}
