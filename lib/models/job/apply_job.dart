class ApplyJob {
  String? customerAccountId;
  String? coverLetter;
  String? resume;

  ApplyJob({
    this.customerAccountId = '',
    this.coverLetter = '',
    this.resume = '',
  });

  ApplyJob.fromJson(Map<String, dynamic> json) {
    customerAccountId = json['customerAccountId'];
    coverLetter = json['coverLetter'];
    resume = json['resume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerAccountId != null) {
      data['customerAccountId'] = customerAccountId;
    }
    // todo decommenter
    /*if (coverLetter != null) data['coverLetter'] = coverLetter;
    if (resume != null) data['resume'] = resume;*/
    return data;
  }
}
