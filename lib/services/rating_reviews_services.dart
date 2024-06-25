import 'package:finalproject/models/review_model.dart';
import 'package:finalproject/routes/api_paths.dart';
import 'package:finalproject/services/firestore_services.dart';

abstract class RatingReviewsServices {
  Future<List<ReviewModel>> getRatingReviews(String workerId);
  final firestoreservices = FirestoreService.instance;
}

class RatingReviewsServicesImpl extends RatingReviewsServices {
  @override
  Future<List<ReviewModel>> getRatingReviews(String workerId) async {
    return await firestoreservices.getCollection(
      path: ApiPaths.ratingsAndReviews(workerId),
      builder: (data, documentId) => ReviewModel.fromMap(data),
    );
  }
}
