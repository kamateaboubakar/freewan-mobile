class Pays {
  String? id;
  String? code;
  String? name;
  int? ext;
  int? phoneNumberLength;

  Pays({this.id, this.code, this.name, this.ext});

  Pays.fromJson(Map<String, dynamic> json) {
    id = json["node"]['id'];
    code = json["node"]['code'];
    name = json["node"]['name'];
    ext = json["node"]['ext'];
    phoneNumberLength = json["node"]["phoneLength"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['ext'] = ext;
    return data;
  }

  String get libelle => ext == null ? "" : "+$ext";

  String? get flag =>
      (code == null) ? null : "assets/images/flags/${code?.toLowerCase()}.png";
}
