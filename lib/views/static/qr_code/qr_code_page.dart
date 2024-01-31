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
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: ListTile(
          dense: true,
          title: Text(
            "Powered by",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            "Freewan",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: GetBuilder<CodeQRGeneratorVctl>(
          init: CodeQRGeneratorVctl(),
          builder: (ctl) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(30),
                    //   ),
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: 100,
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Center(
                    //       child: Image.asset(
                    //         "assets/images/lebedoo_inline_logo.png",
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(7),
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: QrImageView(
                                  data: ctl.qrData.value,
                                  version: 13,
                                  eyeStyle: const QrEyeStyle(
                                    color: AssetColors.blue,
                                  ),
                                  dataModuleStyle: const QrDataModuleStyle(
                                    color: AssetColors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
