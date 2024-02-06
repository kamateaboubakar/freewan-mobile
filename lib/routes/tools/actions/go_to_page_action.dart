import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lebedoo_assets/const/feature_dictionnary.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/routes/tools/abstracts/route_action.dart';
import 'package:wan_mobile/routes/tools/actions/models/stat_item.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';

class GoToRouteAction extends RouteAction {
  final Widget page;
  final FeatureDictionnary feature;
  static final StreamController<List<StatItem>> _streamController =
      StreamController.broadcast();

  const GoToRouteAction({required this.feature, required this.page});

  @override
  void handle() {
    _countOnTapTime();
    Get.to(() => page);
  }

  void _countOnTapTime() async {
    List<StatItem> stats = await _getStats();

    var index = stats.indexWhere((e) => e.name == feature.name);
    if (index != -1) {
      var stat = stats[index];
      stat.count += 1;
      stats[index] = stat;
    } else {
      stats.add(StatItem(name: feature.name, count: 1));
    }
    _streamController.add(stats);
    await Cache.setString(CacheKey.usedFeatures.name, json.encode(stats));
  }

  static Stream<List<FeatureDictionnary>> moreUsedRoutes(
      {int limit = 10}) async* {
    yield* _streamController.stream.map((event) {
      List<StatItem> stats =
          event.where((e) => e.feature != null && e.count >= 3).toList();

      if (event.length > limit) stats = stats.sublist(0, limit);

      stats.sort((a, b) => b.count.compareTo(a.count));
      return stats.map<FeatureDictionnary>((e) => e.feature!).toList();
    });
  }

  static Future<List<StatItem>> _getStats() async {
    var res = await Cache.getString(CacheKey.usedFeatures.name);
    if (res.value.isJson) {
      var items = json.decode(res.value);
      if (items is List) {
        var features = items
            .map((e) => StatItem.fromJson(e))
            .where((e) => e.feature != null)
            .toList();
        return features;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
