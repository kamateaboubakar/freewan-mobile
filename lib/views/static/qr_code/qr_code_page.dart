import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/recevoir_paiement/code_qr_generator_vctl.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AssetColors.blue,
      appBar: AppBar(
        title: const Text("Mon Code QR"),
      ),
      body: GetBuilder<CodeQRGeneratorVctl>(
          init: CodeQRGeneratorVctl(),
          builder: (ctl) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/lebedoo_inline_logo.png",
                                width: 120,
                              ),
                              const Gap(20),
                              QrImageView(
                                embeddedImage:
                                    Image.asset("assets/images/lebedoo.png")
                                        .image,
                                data: ctl.qrData.value,
                                size: 350,
                                eyeStyle: const QrEyeStyle(
                                  color: AssetColors.blue,
                                ),
                                dataModuleStyle: const QrDataModuleStyle(
                                  color: AssetColors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const ListTile(
                      dense: true,
                      title: Text(
                        "Powered by",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "Freewan",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
