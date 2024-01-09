import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/views/routes/menu_button_enum.dart';

class RouteItem {
  bool isFeature = true;
  bool isHidden;
  String? title;
  String? groupe;
  MenuButtonEnum id;
  ButtonMenu button;

  RouteItem(
      {this.title,
      this.isHidden = false,
      this.isFeature = true,
      this.groupe,
      required this.button,
      required this.id});
}
