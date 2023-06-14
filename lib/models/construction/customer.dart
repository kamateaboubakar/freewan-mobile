class Customer {
  String? accountId;
  String? email;
  String? firstName;
  String? lastName;

  Customer({this.accountId, this.email, this.firstName, this.lastName});

  Customer.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountId'] = accountId;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }
}
