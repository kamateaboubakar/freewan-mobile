import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:wan_mobile/api/controllers/pubs/pub_api_ctl.dart';
import 'package:wan_mobile/routes/tools/actions/go_to_page_action.dart';
import 'package:wan_mobile/tools/services/notification_service.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';
import 'package:wan_mobile/routes/routes.dart';
import 'package:wan_mobile/views/static/home/sub_pages/welcome_message_modal.dart';

class HomePageVctl extends ViewController {
  Routes routes = Routes();
  List<Img> ads = [];
  bool displayWelcome;

  HomePageVctl(this.displayWelcome);

  _displayWelcomeMessage() {
    if (displayWelcome) {
      Tools.openModal(WelcomeMessageModal(lastName: user.lastName.value));
    }
  }

  @override
  void onReady() {
    super.onReady();
    _displayWelcomeMessage();
    getPubs();
    _loadFavoriteButtons();
  }

  Future<void> logout() async {
    var res = await Tools.showChoiceMessage(
      title: AppConst.appName,
      message: "Voulez-vous vraiment vous déconnecter ?",
      secondaryColor: AssetColors.blue,
    );
    if (res == true) {
      await EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var res = await UserApiCtl().logout();
      await EasyLoading.dismiss();
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

  @override
  void onInit() {
    super.onInit();
    _initNotificationListener();
  }

  void _loadFavoriteButtons() async {
    // routes.getAllFavoritesButtons();
    GoToRouteAction.loadStats();
  }
}
