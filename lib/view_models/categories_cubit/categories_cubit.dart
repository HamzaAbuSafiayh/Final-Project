import 'package:finalproject/models/categories_model.dart';
import 'package:finalproject/services/categories_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  final categoriesServices = CategoriesServicesImpl();

  void getCategory(String categoryname) async {
    emit(CategoriesLoading());
    try {
      final CategoriesModel category =
          await categoriesServices.getCategory(categoryname);
      emit(CategoryLoaded(category));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  void getCategories() async {
    emit(CategoriesLoading());
    try {
      final List<CategoriesModel> categories =
          await categoriesServices.getCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
