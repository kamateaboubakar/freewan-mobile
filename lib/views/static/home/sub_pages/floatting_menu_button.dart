import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/views/static/scan_pay/scan_pay_camera.dart';
import 'package:lebedoo_assets/const/feature_dictionnary.dart';
import 'package:wan_mobile/views/routes/routes.dart';

class FloatingMenuButton extends StatelessWidget {
  final Routes routes;
  const FloatingMenuButton(this.routes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 77,
            margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.grey.shade100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        children: routes
                            .routesByList(menus: [
                              FeatureDictionnary.cartesBancaires,
                              FeatureDictionnary.transfertArgent,
                            ])
                            .map(
                              (e) => Expanded(
                                child: e.button.copyWith(
                                  iconBackgroundColor: Colors.transparent,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const Gap(85),
                    Expanded(
                      child: Row(
                        children: routes
                            .routesByList(menus: [
                              FeatureDictionnary.ticketBus,
                              FeatureDictionnary.retraitArgent,
                            ])
                            .map(
                              (e) => Expanded(
                                child: Center(
                                  child: e.button.copyWith(
                                    iconBackgroundColor: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, 1),
          child: SizedBox(
            width: 85,
            height: 85,
            child: FittedBox(
              child: FloatingActionButton(
                shape: const CircleBorder(
                  side: BorderSide(
                    color: Colors.blue,
                    width: 1,
                  ),
                ),
                elevation: 0,
                backgroundColor: AssetColors.blue,
                onPressed: () {
                  var page = Get.currentRoute;
                  Get.to(() => ScanPayCamera(page));
                },
                child: Image.asset(
                  "assets/images/icons/scan_float_button.png",
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
