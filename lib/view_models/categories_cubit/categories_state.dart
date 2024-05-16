part of 'categories_cubit.dart';

sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesLoaded extends CategoriesState {
  final List<CategoriesModel> categories;
  CategoriesLoaded(this.categories);
}

final class CategoriesError extends CategoriesState {
  final String message;
  CategoriesError(this.message);
}
