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
    id = json['countryId'];
    code = json['code'];
    label = json['label'];
    callingCode = json['callingCode'];
    phoneNumberLength = json['phoneNumberLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.id;
    data['code'] = this.code;
    data['label'] = this.label;
    data['callingCode'] = this.callingCode;
    data['phoneNumberLength'] = this.phoneNumberLength;
    return data;
  }

  String? get flag =>
      (code == null) ? null : "assets/images/flags/${code?.toLowerCase()}.png";
}
