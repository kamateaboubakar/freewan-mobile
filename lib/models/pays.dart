class Pays {
  int? countryId;
  String? code;
  String? label;
  String? callingCode;
  int? phoneNumberLength;

  Pays(
      {this.countryId,
      this.code,
      this.label,
      this.callingCode,
      this.phoneNumberLength});

  Pays.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    code = json['code'];
    label = json['label'];
    callingCode = json['callingCode'];
    phoneNumberLength = json['phoneNumberLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['code'] = this.code;
    data['label'] = this.label;
    data['callingCode'] = this.callingCode;
    data['phoneNumberLength'] = this.phoneNumberLength;
    return data;
  }

  String get libelle => (callingCode ?? "").replaceAll("00", "+");
}
