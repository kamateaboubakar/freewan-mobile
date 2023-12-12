import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/tools/const/const.dart';
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
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Image.asset(
                Const.inLineAppLogo,
                height: 180,
              ),
            ),
          );
        },
      ),
    );
  }
}
