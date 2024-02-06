import 'package:lebedoo_assets/const/feature_dictionnary.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/routes/tools/abstracts/route_action.dart';
import 'package:wan_mobile/views/static/home/cross_home_page/more_option_home_page.dart';

class GoToMorePageAction extends RouteAction {
  final String groupeTitle;
  final Set<FeatureDictionnary> menus;

  const GoToMorePageAction({required this.menus, required this.groupeTitle});

  @override
  void handle() => Get.to(
        () => MoreOptionHomePage(
          groupeTitle: groupeTitle,
          menus: menus,
        ),
      );
}
