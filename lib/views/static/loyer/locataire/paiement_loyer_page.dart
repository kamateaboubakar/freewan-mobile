import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/static/paiement/paiement_pay_recap.dart';

class PaiementLoyerPage extends StatelessWidget {
  const PaiementLoyerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paiement Loyer"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(33),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: .7,
                color: const Color.fromRGBO(181, 196, 216, 1),
              ),
            ),
            child: Column(
              children: [
                const ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.home),
                  ),
                  title: Text("Appartement A10"),
                ),
                const Divider(),
                ListTile(
                  leading: Image.asset(
                    "assets/images/icons/maison_icon.png",
                    width: 18,
                    height: 18,
                  ),
                  title: const Text("Studio"),
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/images/icons/maison_icon.png",
                    width: 18,
                    height: 18,
                  ),
                  title: const Text("80 000 FCFA"),
                ),
                const Divider(),
                const SizedBox(height: 10),
                CButton(
                  height: 50,
                  minWidth: double.infinity,
                  onPressed: () => Get.to(() => const PaiementRecap()),
                  color: const Color.fromRGBO(71, 36, 251, 0.1),
                  child: const Text(
                    "Paiement dû le 5 Mai 2023",
                    style: TextStyle(
                      color: Color.fromRGBO(71, 36, 251, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CButton(
                  height: 50,
                  minWidth: double.infinity,
                  onPressed: () => Get.to(() => const PaiementRecap()),
                  color: const Color.fromRGBO(13, 51, 159, 1),
                  child: const Text(
                    "Payer",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
