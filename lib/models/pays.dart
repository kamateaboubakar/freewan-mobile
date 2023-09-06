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
    callingCode = json['calling_code'];
    phoneNumberLength = json['phone_number_length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['countryId'] = id;
    data['code'] = code;
    data['label'] = label;
    data['calling_code'] = callingCode;
    data['phone_number_length'] = phoneNumberLength;
    return data;
  }

  String? get flag =>
      (code == null) ? null : "assets/images/flags/${code?.toLowerCase()}.png";
}
