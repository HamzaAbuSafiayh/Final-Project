class ReviewModel {
  final String timestamp;
  final String review;
  final double rating;
  final String userID;
  ReviewModel({
    required this.timestamp,
    required this.review,
    required this.rating,
    required this.userID,
  });

  ReviewModel copyWith({
    String? timestamp,
    String? review,
    double? rating,
    String? userID,
  }) {
    return ReviewModel(
      timestamp: timestamp ?? this.timestamp,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'timestamp': timestamp});
    result.addAll({'review': review});
    result.addAll({'rating': rating});
    result.addAll({'userID': userID});

    return result;
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      timestamp: map['timestamp'] ?? '',
      review: map['review'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      userID: map['userID'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ReviewModel(timestamp: $timestamp, review: $review, rating: $rating, userID: $userID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewModel &&
        other.timestamp == timestamp &&
        other.review == review &&
        other.rating == rating &&
        other.userID == userID;
  }

  @override
  int get hashCode {
    return timestamp.hashCode ^
        review.hashCode ^
        rating.hashCode ^
        userID.hashCode;
  }
}
