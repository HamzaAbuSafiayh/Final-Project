import 'package:finalproject/models/review_model.dart';
import 'package:finalproject/routes/api_paths.dart';
import 'package:finalproject/services/firestore_services.dart';

abstract class RatingReviewsServices {
  Future<List<ReviewModel>> getRatingReviews(String workerId);
  Future<void> addRatingReview(String workerID, ReviewModel review);
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

  @override
  Future<void> addRatingReview(String workerID, ReviewModel review) async {
    await firestoreservices.setData(
        path: ApiPaths.sendRatingAndReview(workerID), data: review.toMap());
  }
}
