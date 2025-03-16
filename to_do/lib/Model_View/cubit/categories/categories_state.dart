part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

class FetchedCategories extends CategoriesState {
  final List<CategoryModel> categories;

  FetchedCategories({required this.categories});
}

class EmptyCategories extends CategoriesState {}

class AddedSuccessfully extends CategoriesState {}

class AddingFailed extends CategoriesState {}
