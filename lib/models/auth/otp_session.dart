class OtpSession {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? phoneNumber;
  String? endDate;
  int? otp;

  OtpSession(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.phoneNumber,
      this.endDate,
      this.otp});

  OtpSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phoneNumber = json['phone_number'];
    endDate = json['end_date'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['phone_number'] = phoneNumber;
    data['end_date'] = endDate;
    data['otp'] = otp;
    return data;
  }
}
