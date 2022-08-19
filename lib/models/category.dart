class Category {
  String? categoryId;
  late String name, imageUrl;
  Category({
    required this.name,
    required this.imageUrl,
  });

  toMap() {
    return {"name": name, "imageUrl": imageUrl};
  }

  Category.fromMap(Map<String, dynamic> map) {
    name = map["name"];
    imageUrl = map["imageUrl"];
  }
}
