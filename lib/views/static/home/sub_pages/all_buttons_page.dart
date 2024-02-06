import 'package:flutter/material.dart';
import 'package:lebedoo_assets/const/feature_dictionnary.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/routes/routes.dart';
import 'package:wan_mobile/routes/tools/actions/on_pressed_action.dart';
import 'package:wan_mobile/tools/const/floating_tool_postion_enum.dart';
import 'package:wan_mobile/views/controllers/home/all_buttons_page_vctl.dart';

class AllButtonsPage extends StatelessWidget {
  final FloatingToolPostion postion;
  final Routes routes;
  final FeatureDictionnary? currentId;
  const AllButtonsPage(
    this.routes, {
    required this.postion,
    this.currentId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllButtonsPageVctl>(
        init: AllButtonsPageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(title: const Text("Fonctionnalités")),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CTextFormField(
                    autofocus: false,
                    hintText: "Rechercher",
                    prefixIcon: const Icon(Icons.search),
                    onChanged: (e) {
                      ctl.search = e;
                      ctl.update();
                    },
                  ),
                ),
                Expanded(
                  child: WrapperBodyGridView(
                    emptyWidget: const EmptyListContent(),
                    listPadding: const EdgeInsets.all(10),
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    loading: false,
                    children: routes
                        .search(value: ctl.search)
                        .map(
                          (e) => Badge(
                            isLabelVisible: currentId == e.id,
                            largeSize: 30,
                            backgroundColor: Colors.transparent,
                            label: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            child: e.button.copyWith(
                              action: OnPressedAction(
                                onPressed: () async {
                                  if (currentId == e.id) {
                                    var rep = await Tools.showChoiceMessage(
                                      title: AppConst.appName,
                                      secondaryColor: AssetColors.blue,
                                      message:
                                          "Voulez-vous supprimer ce raccourci ?",
                                    );
                                    if (rep == true) {
                                      await EasyLoading.show(
                                          maskType: EasyLoadingMaskType.black);
                                      await routes
                                          .removeFavorisToolsButton(postion);
                                      await EasyLoading.dismiss();
                                      Get.back();
                                    }
                                  } else {
                                    await EasyLoading.show(
                                        maskType: EasyLoadingMaskType.black);
                                    await routes.setFavorisToolsButton(
                                        postion, e.id);
                                    await EasyLoading.dismiss();
                                    Get.back();
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
