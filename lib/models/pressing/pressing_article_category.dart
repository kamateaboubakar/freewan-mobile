import 'pressing_article.dart';

class PressingArticleCategory {
  int? id;
  String? name;
  List<PressingArticle>? articles;

  PressingArticleCategory({this.id, this.name, this.articles});

  PressingArticleCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['articles'] != null) {
      articles = <PressingArticle>[];
      json['articles'].forEach((v) {
        articles!.add(PressingArticle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
