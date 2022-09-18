class Category {
  int id = -1;
  String categoryName = '';
  Category();

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        categoryName = json['category_name'] ?? "";

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
  };

}