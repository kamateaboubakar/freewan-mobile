class SecurityQuestion {
  int? id;
  String? code;
  String? label, answer;

  SecurityQuestion({this.id, this.code, this.label});

  SecurityQuestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['securityQuestionId'] = id;
    data['code'] = code;
    // data['label'] = this.label;
    data["answer"] = answer;
    return data;
  }
}
