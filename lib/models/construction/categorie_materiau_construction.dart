class CategorieMateriauConstruction {
  int? categoryId;
  int? parentCategoryId;
  String? label;
  String? description;
  String? imageUrl;

  CategorieMateriauConstruction(
      {this.categoryId,
      this.parentCategoryId,
      this.label,
      this.description,
      this.imageUrl});

  CategorieMateriauConstruction.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    parentCategoryId = json['parentCategoryId'];
    label = json['label'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['parentCategoryId'] = parentCategoryId;
    data['label'] = label;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
