import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class PaiementOperationSucess extends StatelessWidget {
  final String? animationAsset;
  final String? description;

  const PaiementOperationSucess({
    super.key,
    this.animationAsset,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        child: CButton(
          height: 48,
          minWidth: double.infinity,
          onPressed: () async {
            await Get.offAll(() => const HomePage());
            Get.reset();
          },
          child: const Text(
            "Aller à l'accueil",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Paiement effectué avec succès",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 133, 63, 1),
              ),
            ),
            Lottie.asset(
                animationAsset ?? 'assets/lotties/79952-successful.json'),
            if (description != null)
              Text(
                description!,
                textAlign: TextAlign.center,
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 20,
                  color: AssetColors.darkBrown,
                ),
              )
          ],
        ),
      ),
    );
  }
}
