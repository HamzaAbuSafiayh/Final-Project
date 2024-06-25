class OrderModel {
  final String orderId;
  final String workerId;
  final String userId;
  final String job;
  final String location;
  final double cost;
  final String date;
  final String time;
  final String status;
  OrderModel({
    required this.orderId,
    required this.workerId,
    required this.userId,
    required this.job,
    required this.location,
    required this.cost,
    required this.date,
    required this.time,
    required this.status,
  });

  OrderModel copyWith({
    String? orderId,
    String? workerId,
    String? userId,
    String? job,
    String? location,
    double? cost,
    String? date,
    String? time,
    String? status,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      workerId: workerId ?? this.workerId,
      userId: userId ?? this.userId,
      job: job ?? this.job,
      location: location ?? this.location,
      cost: cost ?? this.cost,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'orderId': orderId});
    result.addAll({'workerId': workerId});
    result.addAll({'userId': userId});
    result.addAll({'job': job});
    result.addAll({'location': location});
    result.addAll({'cost': cost});
    result.addAll({'date': date});
    result.addAll({'time': time});
    result.addAll({'status': status});

    return result;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ?? '',
      workerId: map['workerId'] ?? '',
      userId: map['userId'] ?? '',
      job: map['job'] ?? '',
      location: map['location'] ?? '',
      cost: map['cost']?.toDouble() ?? 0.0,
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      status: map['status'] ?? '',
    );
  }

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, workerId: $workerId, userId: $userId, job: $job, location: $location, cost: $cost, date: $date, time: $time, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.orderId == orderId &&
        other.workerId == workerId &&
        other.userId == userId &&
        other.job == job &&
        other.location == location &&
        other.cost == cost &&
        other.date == date &&
        other.time == time &&
        other.status == status;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        workerId.hashCode ^
        userId.hashCode ^
        job.hashCode ^
        location.hashCode ^
        cost.hashCode ^
        date.hashCode ^
        time.hashCode ^
        status.hashCode;
  }
}
