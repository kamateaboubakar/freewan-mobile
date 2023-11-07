import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/views/tools/menu_button_enum.dart';

class RouteItem {
  bool isFeature = true;
  String? title;
  String? groupe;
  MenuButtonEnum menuButtonEnum;
  ButtonMenu button;
  RouteItem(
      {this.title,
      this.isFeature = true,
      this.groupe,
      required this.button,
      required this.menuButtonEnum});
}
