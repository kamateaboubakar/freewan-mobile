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
        ? new JobOffer.fromJson(json['jobOffer'])
        : null;
    motivationLetter = json['motivationLetter'];
    cv = json['cv'];
    cvUrl = json['cvUrl'];
    applicantDetails = json['applicantDetails'] != null
        ? new ApplicantDetails.fromJson(json['applicantDetails'])
        : null;
    appliedAt = json['appliedAt'];
    status = json['status'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.jobOffer != null) {
      data['jobOffer'] = this.jobOffer!.toJson();
    }
    data['motivationLetter'] = this.motivationLetter;
    data['cv'] = this.cv;
    data['cvUrl'] = this.cvUrl;
    if (this.applicantDetails != null) {
      data['applicantDetails'] = this.applicantDetails!.toJson();
    }
    data['appliedAt'] = this.appliedAt;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    data['customerAccountId'] = this.customerAccountId;
    data['cvFilename'] = this.cvFilename;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['login'] = this.login;
    return data;
  }
}
