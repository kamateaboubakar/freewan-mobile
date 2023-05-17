class SecurityQuestion {
  int? id;
  String? code;
  String? label, answer;

  SecurityQuestion({this.id, this.code, this.label});

  SecurityQuestion.fromJson(Map<String, dynamic> json) {
    id = json['securityQuestionId'];
    code = json['code'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['securityQuestionId'] = this.id;
    data['code'] = this.code;
    // data['label'] = this.label;
    data["answer"] = answer;
    return data;
  }
}
