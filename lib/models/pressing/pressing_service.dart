import 'package:wan_mobile/tools/const/const.dart';

class PressingService {
  int? id;
  String? name;
  String? photoLink;

  PressingService({this.id, this.name, this.photoLink});

  PressingService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photoLink = json['photo_link'];
  }

  String get imageUrl => "${Const.pressingImageUrl}/$photoLink";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo_link'] = photoLink;
    return data;
  }
}
