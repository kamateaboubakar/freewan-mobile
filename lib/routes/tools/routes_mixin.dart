import 'package:lebedoo_assets/const/feature_dictionnary.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/routes/route_item.dart';

mixin RoutesMixin {
  List<RouteItem> get routes => [];

  List<RouteItem> routesByGroup({String? groupe}) => routes
      .where((e) => e.groupe.value.isNotEmpty)
      .where((e) => !e.isHidden)
      .where((e) => e.groupe == groupe)
      .toList();

  List<RouteItem> search({String? value}) => routes
      .where((e) => e.button.title.value.isNotEmpty)
      .where((e) => !e.isHidden)
      .where((e) => e.button.title.value
          .toLowerCase()
          .contains(value.value.toLowerCase()))
      .toList()
    ..sort((a, b) => a.button.title.value.compareTo(b.button.title.value));

  List<String> get groupes => routes
      .where((e) => e.groupe.value.isNotEmpty && !e.isHidden)
      .where((e) => !e.isHidden)
      .map((e) => e.groupe.value)
      .toSet()
      .toList()
    ..sort((a, b) => a.compareTo(b));

  RouteItem? routeById({required FeatureDictionnary? id}) =>
      routes.firstWhereOrNull((e) => e.id == id);

  List<RouteItem> routesByList(
      {Set<FeatureDictionnary> menus = const {}, bool sorted = true}) {
    var res = <RouteItem>[];
    if (sorted) {
      res = routes
          .where((e) => menus.contains(e.id))
          .where((e) => !e.isHidden)
          .toList()
        ..sort((a, b) => a.title.value.compareTo(b.title.value));
    } else {
      for (var e in menus) {
        res.addAll(routes
            .where((element) => element.id == e)
            .where((element) => !element.isHidden)
            .toList());
      }
    }
    return res;
  }
}
