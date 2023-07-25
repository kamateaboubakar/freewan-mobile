import 'job_offer.dart';

class ApplyJob {
  int? id;
  JobOffer? jobOffer;
  String? motivationLetter;
  String? cv;
  String? cvFilename;
  String? cvUrl;
  ApplicantDetails? applicantDetails;
  String? appliedAt;
  String? status;
  String? updatedAt;
  String? customerAccountId;

  ApplyJob({
    this.id,
    this.jobOffer,
    this.motivationLetter = '',
    this.cv,
    this.cvUrl,
    this.applicantDetails,
    this.appliedAt,
    this.status,
    this.updatedAt,
    this.customerAccountId,
    this.cvFilename,
  });

  ApplyJob.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobOffer = json['jobOffer'] != null
        ? JobOffer.fromJson(json['jobOffer'])
        : null;
    motivationLetter = json['motivationLetter'];
    cv = json['cv'];
    cvUrl = json['cvUrl'];
    applicantDetails = json['applicantDetails'] != null
        ? ApplicantDetails.fromJson(json['applicantDetails'])
        : null;
    appliedAt = json['appliedAt'];
    status = json['status'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (jobOffer != null) {
      data['jobOffer'] = jobOffer!.toJson();
    }
    if (motivationLetter != null) {
      data['motivationLetter'] = motivationLetter;
    }
    if (cv != null) data['cv'] = cv;
    if (cvUrl != null) data['cvUrl'] = cvUrl;
    if (applicantDetails != null) {
      data['applicantDetails'] = applicantDetails!.toJson();
    }
    if (appliedAt != null) data['appliedAt'] = appliedAt;
    if (status != null) data['status'] = status;
    if (updatedAt != null) data['updatedAt'] = updatedAt;
    if (customerAccountId != null) {
      data['customerAccountId'] = customerAccountId;
    }
    if (cvFilename != null) data['cvFilename'] = cvFilename;
    return data;
  }
}

class ApplicantDetails {
  String? accountId;
  String? email;
  String? firstName;
  String? lastName;
  String? login;

  ApplicantDetails(
      {this.accountId, this.email, this.firstName, this.lastName, this.login});

  ApplicantDetails.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    login = json['login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountId'] = accountId;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['login'] = login;
    return data;
  }

  String get fullName => "$lastName $firstName";
}
