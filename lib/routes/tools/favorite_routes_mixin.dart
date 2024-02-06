import 'dart:async';
import 'dart:convert';

import 'package:lebedoo_assets/const/feature_dictionnary.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools/types/map.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';
import 'package:wan_mobile/tools/const/floating_tool_postion_enum.dart';

mixin FavoriteRoutesMixin {
  Future<FeatureDictionnary?> getFavorisToolsButtonByPosition(
      FloatingToolPostion postion) async {
    var favoris = await Cache.getString(CacheKey.floatingToolsButton.name);
    if (favoris.value.isJson) {
      var item = json.decode(favoris.value);
      if (item is Map) {
        return FeatureDictionnary.values
            .firstWhereOrNull((e) => item[postion.name] == e.name);
      }
    }
    return null;
  }

  Future<void> setFavorisToolsButton(
      FloatingToolPostion postion, FeatureDictionnary id) async {
    var favoris = await Cache.getString(CacheKey.floatingToolsButton.name);
    Json item;
    if (favoris.value.isJson) {
      item = json.decode(favoris.value);
      item[postion.name] = id.name;
    } else {
      item = {postion.name: id.name}.obs;
    }
    await Cache.setString(CacheKey.floatingToolsButton.name, json.encode(item));
  }

  Future<void> removeFavorisToolsButton(FloatingToolPostion postion) async {
    var favoris = await Cache.getString(CacheKey.floatingToolsButton.name);
    if (favoris.value.isJson) {
      Json item;
      item = json.decode(favoris.value);
      item.removeWhere((key, value) => key == postion.name);
      await Cache.setString(
          CacheKey.floatingToolsButton.name, json.encode(item));
    }
  }
}
