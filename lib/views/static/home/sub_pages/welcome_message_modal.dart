import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

class WelcomeMessageModal extends StatelessWidget {
  final String lastName;

  const WelcomeMessageModal({
    required this.lastName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "BIENVENUE $lastName !",
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
    );
  }
}
