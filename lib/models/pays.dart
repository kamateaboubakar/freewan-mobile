class Pays {
  int? id;
  String? code;
  String? label;
  String? callingCode;
  int? phoneNumberLength;

  Pays(
      {this.id,
      this.code,
      this.label,
      this.callingCode,
      this.phoneNumberLength});

  Pays.fromJson(Map<String, dynamic> json) {
    id = json['countryId'] ?? json['id'];
    code = json['code'];
    label = json['label'];
    callingCode = json['callingCode'];
    phoneNumberLength = json['phoneNumberLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['countryId'] = id;
    data['code'] = code;
    data['label'] = label;
    data['callingCode'] = callingCode;
    data['phoneNumberLength'] = phoneNumberLength;
    return data;
  }

  String? get flag =>
      (code == null) ? null : "assets/images/flags/${code?.toLowerCase()}.png";
}
