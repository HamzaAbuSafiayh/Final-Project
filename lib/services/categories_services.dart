import 'package:finalproject/models/categories_model.dart';
import 'package:finalproject/routes/api_paths.dart';
import 'package:finalproject/services/firestore_services.dart';

abstract class CategoriesService {
  Future<List<CategoriesModel>> getCategories();
  Future<CategoriesModel> getCategory(String category);
}

class CategoriesServicesImpl extends CategoriesService {
  @override
  Future<List<CategoriesModel>> getCategories() async =>
      await FirestoreService.instance.getCollection(
        path: ApiPaths.categories(),
        builder: (data, documentId) => CategoriesModel.fromMap(data),
      );

  @override
  Future<CategoriesModel> getCategory(String category) async {
    final categories = await getCategories();
    return categories.firstWhere((element) => element.name == category);
  }
}
