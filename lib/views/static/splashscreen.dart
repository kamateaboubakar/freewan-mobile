import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_master/module_master.dart';

import 'package:wan_mobile/views/controllers/splashscreen_vctl.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<SplashscreenVctl>(
        init: SplashscreenVctl(),
        builder: (ctl) {
          return Center(
            child: Image.asset(
              Const.inLineAppLogo,
              height: 180,
            ),
          );
        },
      ),
    );
  }
}
