class WorkerModel {
  final String job;
  final String location;
  final String uid;
  final double sumofratings;
  final int reviews;
  WorkerModel({
    required this.job,
    required this.location,
    required this.uid,
    required this.sumofratings,
    required this.reviews,
  });
  

  WorkerModel copyWith({
    String? job,
    String? location,
    String? uid,
    double? sumofratings,
    int? reviews,
  }) {
    return WorkerModel(
      job: job ?? this.job,
      location: location ?? this.location,
      uid: uid ?? this.uid,
      sumofratings: sumofratings ?? this.sumofratings,
      reviews: reviews ?? this.reviews,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'job': job});
    result.addAll({'location': location});
    result.addAll({'uid': uid});
    result.addAll({'sumofratings': sumofratings});
    result.addAll({'reviews': reviews});
  
    return result;
  }

  factory WorkerModel.fromMap(Map<String, dynamic> map) {
    return WorkerModel(
      job: map['job'] ?? '',
      location: map['location'] ?? '',
      uid: map['uid'] ?? '',
      sumofratings: map['sumofratings']?.toDouble() ?? 0.0,
      reviews: map['reviews']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'WorkerModel(job: $job, location: $location, uid: $uid, sumofratings: $sumofratings, reviews: $reviews)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is WorkerModel &&
      other.job == job &&
      other.location == location &&
      other.uid == uid &&
      other.sumofratings == sumofratings &&
      other.reviews == reviews;
  }

  @override
  int get hashCode {
    return job.hashCode ^
      location.hashCode ^
      uid.hashCode ^
      sumofratings.hashCode ^
      reviews.hashCode;
  }
}
