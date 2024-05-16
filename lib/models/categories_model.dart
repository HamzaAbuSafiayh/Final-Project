class CategoriesModel {
  final String name;
  final String imageUrl;
  CategoriesModel({
    required this.name,
    required this.imageUrl,
  });

  CategoriesModel copyWith({
    String? name,
    String? imageUrl,
  }) {
    return CategoriesModel(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'imageUrl': imageUrl});
  
    return result;
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
  
  @override
  String toString() => 'CategoriesModel(name: $name, imageUrl: $imageUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CategoriesModel &&
      other.name == name &&
      other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => name.hashCode ^ imageUrl.hashCode;
}
