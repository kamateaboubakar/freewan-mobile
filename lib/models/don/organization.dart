class Organization {
  int? id;
  String? customerAccountId;
  String? name;
  String? description;
  String? email;
  String? address;
  String? phoneNumber;
  String? createdAt;
  bool? verified;
  String? logo;
  String? logoUrl;

  Organization(
      {this.id,
      this.customerAccountId,
      this.name,
      this.description,
      this.email,
      this.address,
      this.phoneNumber,
      this.createdAt,
      this.verified,
      this.logo,
      this.logoUrl});

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerAccountId = json['customerAccountId'];
    name = json['name'];
    description = json['description'];
    email = json['email'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    createdAt = json['createdAt'];
    verified = json['verified'];
    logo = json['logo'];
    logoUrl = json['logoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['customerAccountId'] = customerAccountId;
    data['name'] = name;
    data['description'] = description;
    data['email'] = email;
    data['address'] = address;
    data['phoneNumber'] = phoneNumber;
    data['createdAt'] = createdAt;
    data['verified'] = verified;
    data['logo'] = logo;
    data['logoUrl'] = logoUrl;
    return data;
  }
}
