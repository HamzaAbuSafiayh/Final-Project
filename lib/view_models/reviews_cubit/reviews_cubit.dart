import 'package:finalproject/models/review_model.dart';
import 'package:finalproject/services/rating_reviews_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ratingsandreviews = RatingReviewsServicesImpl();
  ReviewsCubit() : super(ReviewsInitial());
  void addReview(String workerID, ReviewModel review) async {
    try {
      await ratingsandreviews.addRatingReview(workerID, review);
      emit(ReviewSent(review));
    } catch (e) {
      emit(ReviewsError(e.toString()));
    }
  }

  void getReviews(String workerId) async {
    emit(ReviewsLoading());
    try {
      final reviews = await ratingsandreviews.getRatingReviews(workerId);
      emit(ReviewsLoaded(reviews));
    } catch (e) {
      emit(ReviewsError(e.toString()));
    }
  }
}
