import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class HomePageVctl extends ViewController {
  List<String> ads = [
    "https://www.wordstream.com/wp-content/uploads/2021/07/persuasive-ads-coca-cola-1.jpg",
    "https://165225.fs1.hubspotusercontent-na1.net/hubfs/165225/Video-ads-meta.jpg",
    "https://www.shutterstock.com/image-vector/deluxe-king-size-burger-ads-260nw-1121447561.jpg"
  ];
  final displayWelcome;

  HomePageVctl(this.displayWelcome);

  DraggableScrollableController scrollController =
      DraggableScrollableController();

  int currentAds = 0;
  bool smallButton = false;

  @override
  void onInit() {
    super.onInit();
    _displayWelcomeMessage();

    scrollController.addListener(() {
      if (scrollController.pixels == 754.4) {
        smallButton = true;
        update();
      } else if (scrollController.pixels == 565.8) {
        smallButton = false;
        update();
      }
    });
  }

  _displayWelcomeMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (displayWelcome) {
        Tools.openModal(
          Container(
            // width: Get.width,
            height: 500,

            // margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(16, 54, 162, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  "BIENVENUE ${appCtl.user.prenom} !",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/96325-party-hat.png"),
                        const Text(
                          "Vous pouvez maintenant payer pour tous vos services avec "
                          "1 seule application",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                CButton(
                  height: 48,
                  minWidth: 255,
                  color: const Color.fromRGBO(0, 159, 249, 1),
                  onPressed: () => Get.back(),
                  child: const Text(
                    "Super! j’ai hâte!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
        );
      }
    });
  }

  @override
  void dispose() {
    print("######################################");
    scrollController.removeListener(() {});

    scrollController.dispose();

    update();

    super.dispose();
  }
}
