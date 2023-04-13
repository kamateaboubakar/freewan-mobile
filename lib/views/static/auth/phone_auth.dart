import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/auth/choose_language_page.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class PhoneAuth extends StatelessWidget {
  const PhoneAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          "Le lorem ipsum est, en imprimerie, une suite de mots sans "
          "signification utilisée à titre provisoire pour calibrer une"
          " mise en page, le texte définitif venant remplacer",
          style: TextStyle(fontSize: 11),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () => Get.to(() => const ChooseLanguagePage()),
                  child: const Text("Change Language"),
                ),
                const SizedBox(width: 10),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () => Get.offAll(() => const HomePage()),
                  child: const Text("Skip"),
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Connectez-vous ou créez votre compte",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 5),
            const Text(
                "Payez en utilisant UPI, portefeuille, comptes bancaires et cartes"),
            const SizedBox(height: 20),
            Row(
              children: [
                Center(
                  child: Container(
                    width: 55,
                    height: 56,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Text(
                        "+225",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: CTextFormField(
                      margin: EdgeInsets.zero,
                      hintText: "Numéro de téléphone",
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text("Besoin d'aide?"),
                )
              ],
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              value: true,
              dense: true,
              onChanged: (value) {},
              title: const Text(
                "Le lorem ipsum est, en imprimerie, une suite de mots sans "
                "signification utilisée à titre provisoire pour calibrer une"
                " mise en page, le texte définitif venant remplacer",
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 70,
              padding: const EdgeInsets.all(8.0),
              child: CButton(
                onPressed: () => Get.off(() => const HomePage()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.lock, size: 16),
                    SizedBox(width: 10),
                    Text(
                      "CONNEXION",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
