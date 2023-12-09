import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/views/tools/menu_button_enum.dart';

class RouteItem {
  bool isFeature = true;
  bool isHidden;
  String? title;
  String? groupe;
  MenuButtonEnum menuId;
  ButtonMenu button;

  RouteItem(
      {this.title,
      this.isHidden = false,
      this.isFeature = true,
      this.groupe,
      required this.button,
      required this.menuId});
}
