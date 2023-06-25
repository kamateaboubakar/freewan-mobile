class BienImmobilier {
  String? createdAt;
  String? updatedAt;
  int? active;
  int? version;
  int? id;
  String? ownerId;

  BienImmobilier({
    this.createdAt,
    this.updatedAt,
    this.active,
    this.version,
    this.id,
    this.ownerId,
  });

  BienImmobilier.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
      active = json['active'];
      version = json['version'];
      id = json['id'];
      ownerId = json['ownerId'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['active'] = active;
    data['version'] = version;
    data['id'] = id;
    data['ownerId'] = ownerId;
    return data;
  }
}
