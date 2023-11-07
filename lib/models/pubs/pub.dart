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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['categorie'] = categorie;
    data['date_end'] = dateEnd;
    data['redirection_url'] = redirectionUrl;
    data['second_url'] = secondUrl;
    return data;
  }
}
