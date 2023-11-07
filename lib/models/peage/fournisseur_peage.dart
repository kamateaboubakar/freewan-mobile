class FournisseurPeage {
  int? id;
  String? libelle;

  FournisseurPeage({this.id, this.libelle});

  FournisseurPeage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['libelle'] = libelle;
    return data;
  }
}
