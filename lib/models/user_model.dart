
class UserModel {
  String username;
  String role;
  String email;
  String imageUrl;
  UserModel({
    required this.username,
    required this.role,
    required this.email,
    required this.imageUrl,
  });
  

  UserModel copyWith({
    String? username,
    String? role,
    String? email,
    String? imageUrl,
  }) {
    return UserModel(
      username: username ?? this.username,
      role: role ?? this.role,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'username': username});
    result.addAll({'role': role});
    result.addAll({'email': email});
    result.addAll({'imageUrl': imageUrl});
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      role: map['role'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
  @override
  String toString() {
    return 'UserModel(username: $username, role: $role, email: $email, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.username == username &&
      other.role == role &&
      other.email == email &&
      other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return username.hashCode ^
      role.hashCode ^
      email.hashCode ^
      imageUrl.hashCode;
  }
}
