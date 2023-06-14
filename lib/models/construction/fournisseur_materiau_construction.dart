class FournisseurMateriauConstruction {
  int? brandId;
  String? label;

  FournisseurMateriauConstruction({this.brandId, this.label});

  FournisseurMateriauConstruction.fromJson(Map<String, dynamic> json) {
    brandId = json['brandId'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brandId'] = brandId;
    data['label'] = label;
    return data;
  }
}
