import 'package:wan_mobile/models/security_question.dart';

class User {
  String? id;
  String? phoneNumber;
  String? countryCallingCode;
  String? email;
  String? password;
  String? nom, prenom;
  DateTime? dateNaissance;

  List<SecurityQuestion>? securityQuestions;

  User(
      {this.phoneNumber,
      this.countryCallingCode,
      this.email,
      this.password,
      this.securityQuestions});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = id;
    data['phoneNumber'] = phoneNumber;
    data['countryCallingCode'] = countryCallingCode;
    data['email'] = email;
    data['password'] = password;
    data['dateNaissance'] = dateNaissance?.toIso8601String();
    if (securityQuestions != null) {
      data['securityQuestions'] =
          securityQuestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
