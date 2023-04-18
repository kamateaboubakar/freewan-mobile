import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/controllers/splashscreen_vctl.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashscreenVctl>(
          init: SplashscreenVctl(),
          builder: (ctl) {
            return Center(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        "assets/images/logo_bedoo.png",
                        width: 141,
                        height: 63,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(strokeWidth: 1.2),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Wwan 2023 - V0.0.1",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
