class Pub {
  String? title;
  String? description;
  String? url;
  String? categorie;
  String? dateEnd;
  String? redirectionUrl;
  String? secondUrl;

  Pub(
      {this.title,
      this.description,
      this.url,
      this.categorie,
      this.dateEnd,
      this.redirectionUrl,
      this.secondUrl});

  Pub.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    url = json['url'];
    categorie = json['categorie'];
    dateEnd = json['date_end'];
    redirectionUrl = json['redirection_url'];
    secondUrl = json['second_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['categorie'] = this.categorie;
    data['date_end'] = this.dateEnd;
    data['redirection_url'] = this.redirectionUrl;
    data['second_url'] = this.secondUrl;
    return data;
  }
}
