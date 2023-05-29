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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['description'] = this.description;
    return data;
  }
}
