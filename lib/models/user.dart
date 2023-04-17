import 'package:wan_mobile/models/security_question.dart';

class User {
  String? phoneNumber;
  String? countryCallingCode;
  String? email;
  String? password;
  List<SecurityQuestion>? securityQuestions;

  User(
      {this.phoneNumber,
      this.countryCallingCode,
      this.email,
      this.password,
      this.securityQuestions});

  User.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    countryCallingCode = json['countryCallingCode'];
    email = json['email'];
    password = json['password'];
    if (json['securityQuestions'] != null) {
      securityQuestions = <SecurityQuestion>[];
      json['securityQuestions'].forEach((v) {
        securityQuestions!.add(SecurityQuestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['countryCallingCode'] = this.countryCallingCode;
    data['email'] = this.email;
    data['password'] = this.password;
    if (this.securityQuestions != null) {
      data['securityQuestions'] =
          this.securityQuestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
