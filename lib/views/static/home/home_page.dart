import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/home/cross_home_page/categorized_home.dart';
import 'package:wan_mobile/views/static/home/home_drawer.dart';
import 'package:wan_mobile/views/static/home/sub_pages/floatting_menu_button.dart';
import 'package:wan_mobile/views/static/home/sub_pages/home_body.dart';
import 'package:wan_mobile/views/static/notification/notification_list_page.dart';

class HomePage extends StatelessWidget {
  final bool displayWelcome;

  const HomePage({this.displayWelcome = false, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageVctl>(
      init: HomePageVctl(displayWelcome),
      builder: (ctl) {
        return Scaffold(
          backgroundColor: Colors.blue.shade50,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leadingWidth: 45,
            // backgroundColor: AssetColors.blue,
            // foregroundColor: Colors.white,
            foregroundColor: AssetColors.blue,
            backgroundColor: Colors.transparent,
            leading: Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: const Icon(IcoFontIcons.navigationMenu),
                ),
              );
            }),
            title: Image.asset(
              Const.inLineAppLogo,
              width: 130,
              height: 110,
              // color: Colors.white,
            ),
            actions: [
              IconButton(
                iconSize: 20,
                splashRadius: 20,
                onPressed: () => Get.to(() => const CategorizedHome()),
                icon: const Icon(IcoFontIcons.search1),
              ),
              Obx(
                () => Badge(
                  isLabelVisible: ctl.appCtl.notifAccount.value > 0,
                  label: Text(ctl.appCtl.notifAccount.value.toString()),
                  offset: const Offset(-5, 5),
                  child: IconButton(
                    splashRadius: 20,
                    onPressed: () => Get.to(() => const NotificationListPage()),
                    icon: const Icon(IcoFontIcons.notification),
                  ),
                ),
              )
            ],
          ),
          drawer: HomeDrawer(ctl),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingMenuButton(ctl),
          body: HomeBody(ctl),
        );
      },
    );
  }
}
