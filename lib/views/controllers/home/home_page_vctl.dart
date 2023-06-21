import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wan_mobile/api/controllers/user_api_ctl.dart';
import 'package:wan_mobile/tools/cache/cache.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';

class HomePageVctl extends ViewController {
  List<String> ads = [
    "https://www.wordstream.com/wp-content/uploads/2021/07/persuasive-ads-coca-cola-1.jpg",
    "https://165225.fs1.hubspotusercontent-na1.net/hubfs/165225/Video-ads-meta.jpg",
    "https://www.shutterstock.com/image-vector/deluxe-king-size-burger-ads-260nw-1121447561.jpg"
  ];
  bool displayWelcome;

  var scrollController = ScrollController();

  var isScrolling = false.obs;

  HomePageVctl(this.displayWelcome);

  PanelController panelController = PanelController();

  int currentAds = 0;
  bool smallButton = false;

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
                  "BIENVENUE ${appCtl.user.lastName} !",
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

  Future<void> fetchUserProfil() async {
    var res = await UserApiCtl().getUserProfil();
    if (res.status) {
      appCtl.user = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  @override
  void onReady() {
    super.onReady();
    _displayWelcomeMessage();
    fetchUserProfil();
  }

  Future<void> logout() async {
    var res = await Tools.showChoiceMessage(
        message: "Voulez-vous vraiment vous déconnecter ?");
    if (res == true) {
      await pr.show();
      var res = await UserApiCtl().logout();
      await pr.hide();
      if (res.status) {
        await Cache.remove(CacheKey.credentials);
        Get.off(() => const PhoneAuth());
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }
}
