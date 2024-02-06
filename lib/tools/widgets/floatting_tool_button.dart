import 'package:flutter/material.dart';
import 'package:lebedoo_assets/const/feature_dictionnary.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/routes/tools/actions/on_pressed_action.dart';
import 'package:wan_mobile/tools/const/floating_tool_postion_enum.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/home/sub_pages/all_buttons_page.dart';

class FloatingToolButton extends StatelessWidget {
  final HomePageVctl ctl;
  final FloatingToolPostion postion;
  const FloatingToolButton(
    this.ctl, {
    required this.postion,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FeatureDictionnary?>(
      future: ctl.routes.getFavorisToolsButtonByPosition(postion),
      builder: (context, snapshot) {
        var routeItem = ctl.routes.routeById(id: snapshot.data);
        if (routeItem != null) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
            child: routeItem.button.copyWith(onLongPress: () async {
              await Get.to(
                () => AllButtonsPage(
                  ctl.routes,
                  postion: postion,
                  currentId: snapshot.data,
                ),
              );
              ctl.update();
            }),
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
            child: ButtonMenu(
              icon: const Icon(
                Icons.add,
                color: AssetColors.blue,
              ),
              action: OnPressedAction(onPressed: () async {
                await Get.to(
                  () => AllButtonsPage(
                    ctl.routes,
                    postion: postion,
                    currentId: snapshot.data,
                  ),
                );
                ctl.update();
              }),
            ),
          );
        }
      },
    );
  }
}
