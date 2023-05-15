import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/static/auth/otp_auth.dart';
import 'package:wan_mobile/views/static/paiement/paiement_pay_recap.dart';

import '../../../tools/utils/asset_colors.dart';

class PaiementChoixNumero extends StatelessWidget {
  const PaiementChoixNumero({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Choix du numéro"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () => Tools.openBottomSheet(
          Container(
            padding: const EdgeInsets.only(
              right: 30,
              left: 30,
              top: 35,
              bottom: 19,
            ),
            height: 219,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "Entrez le numéro de paiement",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                const CTextFormField(
                  hintText: "Enter your mobile number",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            width: 1,
                            color: AssetColors.blueButton,
                          ),
                        ),
                        height: 48,
                        onPressed: () {},
                        child: const Text(
                          "Annuler",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AssetColors.blueButton,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CButton(
                        borderRadius: 8,
                        height: 48,
                        onPressed: () => Get.to(
                          () => OPTAuth(
                            phone: "phone",
                            onSubmit: (code) => Get.back(),
                          ),
                        ),
                        child: const Text(
                          "Confirmer",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        label: const Text("Ajouter un autre numéro"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
            children: ["07 07 45 25 23"]
                .map(
                  (e) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      tileColor: const Color.fromRGBO(237, 242, 249, 1),
                      title: const Text(
                        "Utiliser mon numéro",
                        style: TextStyle(
                          color: Color.fromRGBO(72, 76, 79, 1),
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        e,
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Color.fromRGBO(7, 21, 60, 1),
                      ),
                      onTap: () => Get.to(() => const PaiementRecap()),
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }
}
