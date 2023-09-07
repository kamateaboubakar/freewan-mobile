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
  String? fcmToken;

  List<SecurityQuestion> securityQuestions = [];

  User({
    this.phoneNumber,
    this.countryCallingCode,
    this.email,
    this.password,
    this.id,
    this.securityQuestions = const [],
    this.firstName,
    this.lastName,
    this.birthDate,
    this.fcmToken,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'] ?? json["login"];
    email = json['email'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fcmToken = json['fcm_token'];
    if (json['securityQuestions'] != null) {
      securityQuestions = <SecurityQuestion>[];
      json['securityQuestions'].forEach((v) {
        securityQuestions.add(SecurityQuestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['login'] = phoneNumber;
    data['email'] = email;
    data['password'] = password;
    if (birthDate != null) {
      data['birth_date'] = birthDate!.toStringDateOnly();
    } else {
      data["birth_date"] = null;
    }
    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["fcm_token"] = fcmToken;
    data['security_questions'] =
        securityQuestions.map((v) => v.toJson()).toList();

    return data;
  }

  String get fullName => "${firstName.value} ${lastName.value}";

  String get firstPrenom => firstName.value.split(" ").first;
}
