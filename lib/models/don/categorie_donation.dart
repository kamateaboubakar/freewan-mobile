class CategorieDonation {
  int? id;
  String? label;
  String? description;
  String? icon;
  String? iconUrl;
  bool isAllOption = false;

  CategorieDonation(
      {this.id,
      this.label,
      this.description,
      this.icon,
      this.iconUrl,
      this.isAllOption = false});

  CategorieDonation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    description = json['description'];
    icon = json['icon'];
    iconUrl = json['iconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['label'] = label;
    data['description'] = description;
    data['icon'] = icon;
    data['iconUrl'] = iconUrl;
    return data;
  }
}
