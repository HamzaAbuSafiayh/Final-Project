part of 'categories_cubit.dart';

sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesLoaded extends CategoriesState {
  final List<CategoriesModel> categories;
  CategoriesLoaded(this.categories);
}

final class CategoryLoaded extends CategoriesState {
  final CategoriesModel category;
  CategoryLoaded(this.category);
}

final class CategoriesError extends CategoriesState {
  final String message;
  CategoriesError(this.message);
}
