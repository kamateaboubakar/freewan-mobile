import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
                children: const [
                  Expanded(
                    child: Center(
                      child: Text("Logo"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(strokeWidth: 1.2),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Version 1.0.0",
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
