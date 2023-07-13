class Company {
  int? id;
  int? activitySectorId;
  String? name;
  String? email;
  String? legalForm;
  String? address;
  String? phoneNumber;
  String? createdAt;
  double? employeesCount;
  double? revenues;
  bool? verified;
  String? logo;
  String? logoUrl;
  String? customerAccountId;
  String? description;

  Company({
    this.id,
    this.activitySectorId,
    this.name = '',
    this.email = '',
    this.legalForm = '',
    this.address = '',
    this.phoneNumber = '',
    this.createdAt,
    this.employeesCount = 0,
    this.revenues = 0,
    this.verified = false,
    this.logo,
    this.logoUrl,
    this.customerAccountId,
    this.description,
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activitySectorId = json['activitySectorId'];
    name = json['name'];
    email = json['email'];
    legalForm = json['legalForm'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    createdAt = json['createdAt'];
    employeesCount = json['employeesCount'];
    revenues = json['revenues'];
    verified = json['verified'];
    logo = json['logo'];
    logoUrl = json['logoUrl'];
    customerAccountId = json['customerAccountId'];
    description = json['description'];
  }

  bool get hasInformationFilled =>
      name!.isNotEmpty &&
      activitySectorId != null &&
      email!.isNotEmpty &&
      address!.isNotEmpty &&
      description!.isNotEmpty;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activitySectorId'] = this.activitySectorId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['legalForm'] = this.legalForm;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['createdAt'] = this.createdAt;
    data['employeesCount'] = this.employeesCount;
    data['revenues'] = this.revenues;
    data['verified'] = this.verified;
    data['logo'] = this.logo;
    data['customerAccountId'] = this.customerAccountId;
    data['description'] = this.description;
    return data;
  }
}
