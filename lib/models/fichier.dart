class Fichier {
  String? filename;
  String? url;

  Fichier({this.filename, this.url});

  Fichier.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    data['url'] = url;
    return data;
  }
}
