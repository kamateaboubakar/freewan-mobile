import 'package:tools_flutter_project/tools_flutter_project.dart';

class Adresse {
  int? id;
  int? userId;
  String? libelle;
  String? locationLabel;
  double? latitude;
  double? longitude;

  Adresse({this.libelle, this.userId, this.latitude, this.longitude});

  Adresse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    userId = json['user_id'];
    latitude = json['latitude'].toString().toDouble();
    longitude = json['longitude'].toString().toDouble();
    locationLabel = json['location_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['libelle'] = libelle;
    data['user_id'] = userId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location_label'] = locationLabel;
    return data;
  }
}
