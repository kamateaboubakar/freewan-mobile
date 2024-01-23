import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:lebedoo_assets/const/feature_dictionnary.dart';

class RouteItem {
  bool isFeature = true;
  bool isHidden;
  String? title;
  String? groupe;
  FeatureDictionnary id;
  ButtonMenu button;

  RouteItem(
      {this.title,
      this.isHidden = false,
      this.isFeature = true,
      this.groupe,
      required this.button,
      required this.id});
}
