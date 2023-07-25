class WorkExperience {
  int? id;
  String? label;
  String? description;

  WorkExperience({this.id, this.label, this.description});

  WorkExperience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['description'] = description;
    return data;
  }
}
