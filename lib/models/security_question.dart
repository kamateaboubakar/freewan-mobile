class SecurityQuestion {
  String? id;
  String? name, answer;

  SecurityQuestion({this.id, this.name});

  SecurityQuestion.fromJson(Map<String, dynamic> json) {
    id = json["node"]['id'];
    name = json["node"]['name'];
  }

  SecurityQuestion.toResponse(Map<String, dynamic> json) {
    answer = json["node"]['questionAnswers'];
    id = json["node"]["questions"]["id"];
    name = json["node"]["questions"]['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['answer'] = answer;
    return data;
  }
}
