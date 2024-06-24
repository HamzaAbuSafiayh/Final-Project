class ChatRoomModel {
  final List<String> users;
  final String id;

  ChatRoomModel({
    required this.users,
    required this.id,
  });

  ChatRoomModel copyWith({
    List<String>? users,
    String? id,
  }) {
    return ChatRoomModel(
      users: users ?? this.users,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'users': users});
    result.addAll({'id': id});
  
    return result;
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      users: List<String>.from(map['users']),
      id: map['id'] ?? '',
    );
  }

  @override
  String toString() => 'ChatRoomModel(users: $users, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ChatRoomModel &&
      other.users == users &&
      other.id == id;
  }

  @override
  int get hashCode => users.hashCode ^ id.hashCode;
}
