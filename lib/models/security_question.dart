class SecurityQuestion {
  int? securityQuestionId;
  String? code;
  String? label;
  String? answer;

  SecurityQuestion({this.securityQuestionId, this.code, this.label});

  SecurityQuestion.fromJson(Map<String, dynamic> json) {
    securityQuestionId = json['securityQuestionId'];
    code = json['code'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['securityQuestionId'] = this.securityQuestionId;
    data["answer"] = this.answer;
    return data;
  }
}
