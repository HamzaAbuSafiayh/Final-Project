part of 'reviews_cubit.dart';

sealed class ReviewsState {}

final class ReviewsInitial extends ReviewsState {}

final class ReviewsLoading extends ReviewsState {}

final class ReviewsLoaded extends ReviewsState {
  final List<ReviewModel> reviews;

  ReviewsLoaded(this.reviews);
}

final class ReviewSent extends ReviewsState {
  final ReviewModel review;

  ReviewSent(this.review);
}

final class ReviewsError extends ReviewsState {
  final String message;

  ReviewsError(this.message);
}
