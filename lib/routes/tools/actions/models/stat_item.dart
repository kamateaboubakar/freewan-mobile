import 'package:lebedoo_assets/const/feature_dictionnary.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';

class StatItem {
  String name;
  int count;

  StatItem({required this.name, required this.count});

  StatItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        count = json['count'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'count': count,
      };

  FeatureDictionnary? get feature =>
      FeatureDictionnary.values.firstWhereOrNull((e) => e.name == name);
}
