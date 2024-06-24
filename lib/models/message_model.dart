class MessageModel {
  final String message;
  final String senderId;
  final String timestamp;
  MessageModel({
    required this.message,
    required this.senderId,
    required this.timestamp,
  });

  MessageModel copyWith({
    String? message,
    String? senderId,
    String? timestamp,
  }) {
    return MessageModel(
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'message': message});
    result.addAll({'senderId': senderId});
    result.addAll({'timestamp': timestamp});

    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] ?? '',
      senderId: map['senderId'] ?? '',
      timestamp: map['timestamp'] ?? '',
    );
  }

  @override
  String toString() =>
      'MessageModel(message: $message, senderId: $senderId, timestamp: $timestamp)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.message == message &&
        other.senderId == senderId &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode => message.hashCode ^ senderId.hashCode ^ timestamp.hashCode;
}
