class MaterialUnit {
  int? unitId;
  String? code;
  String? label;

  MaterialUnit({this.unitId, this.code, this.label});

  MaterialUnit.fromJson(Map<String, dynamic> json) {
    unitId = json['unitId'];
    code = json['code'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unitId'] = unitId;
    data['code'] = code;
    data['label'] = label;
    return data;
  }
}
