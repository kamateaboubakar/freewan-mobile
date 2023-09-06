import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/tools/types/types.dart';

class User {
  int? id;
  String? phoneNumber;
  String? countryCallingCode;
  String? email;
  String? password;
  String? firstName, lastName;
  DateTime? birthDate;

  List<SecurityQuestion> securityQuestions = [];

  User({
    this.phoneNumber,
    this.countryCallingCode,
    this.email,
    this.password,
    this.id,
    this.securityQuestions = const [],
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'] ?? json["login"];
    countryCallingCode = json['countryCallingCode'];
    email = json['email'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    if (json['securityQuestions'] != null) {
      securityQuestions = <SecurityQuestion>[];
      json['securityQuestions'].forEach((v) {
        securityQuestions.add(SecurityQuestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['phoneNumber'] = phoneNumber;
    data['countryCallingCode'] = countryCallingCode;
    data['email'] = email;
    data['password'] = password;
    if (birthDate != null) {
      data['birthDate'] = birthDate!.toStringDateOnly();
    } else {
      data["birthDate"] = null;
    }
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data['securityQuestions'] =
        securityQuestions.map((v) => v.toJson()).toList();

    return data;
  }

  String get fullName => "${firstName.value} ${lastName.value}";

  String get firstPrenom => firstName.value.split(" ").first;
}
