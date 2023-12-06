import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:wan_mobile/api/controllers/pubs/pub_api_ctl.dart';
import 'package:wan_mobile/models/pubs/pub.dart';
import 'package:wan_mobile/tools/const/const.dart';

import 'package:wan_mobile/tools/services/notification_service.dart';

import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';
import 'package:wan_mobile/views/tools/routes.dart';

class HomePageVctl extends ViewController {
  Routes routes = Routes();

  List<Pub> ads = [];

  bool displayWelcome;
  int nbNotif = 0;

  var scrollController = ScrollController();

  var isScrolling = false.obs;
  PageController pageViewCtl = PageController();
  bool hideAmount = false;

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
        );
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    _displayWelcomeMessage();
    getPubs();
  }

  Future<void> logout() async {
    var res = await Tools.showChoiceMessage(
        message: "Voulez-vous vraiment vous déconnecter ?");
    if (res == true) {
      await pr.show();
      var res = await UserApiCtl().logout();
      await pr.hide();
      if (res.status) {
        await Cache.clear();
        Get.off(() => const PhoneAuth());
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }

  Future<void> _initNotificationListener() async {
    //Update the fcmToken
    var res = await UserApiCtl().updateFCMToken();
    if (res.status) {
      //listen the remote notification
      NotificationService.listNotification(
        handler: (message) {
          appCtl.notifAccount.value++;
        },
      );
    }
  }

  Future<void> getPubs() async {
    var res = await PubApiCtl().getAll();
    if (res.status) {
      ads = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  Future<void> shareAppText({required String codeParrain}) async {
    Share.share(
        """😀 hey, inscris-toi sur *${Const.appName}* avec mon code de parrain : *$codeParrain*

Le premier Hub de service ivoirien totalement digital.

Téléchargez directement l'application sur :
AppStore : ${Const.appStoreLink}
PlayStore : ${Const.playStoreLink}

🥳🥳 ${Const.appSlogan}""");
  }

  @override
  void onInit() {
    super.onInit();
    _initNotificationListener();
  }
}
