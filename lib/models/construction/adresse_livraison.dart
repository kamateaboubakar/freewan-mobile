class AdresseLivraison {
  int? id;
  String? accountId;
  String? label;
  int? longitude;
  int? latitude;

  AdresseLivraison(
      {this.id, this.accountId, this.label, this.longitude, this.latitude});

  AdresseLivraison.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    label = json['label'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['accountId'] = accountId;
    data['label'] = label;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
