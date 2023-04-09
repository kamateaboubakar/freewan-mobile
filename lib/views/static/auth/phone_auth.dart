import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class PhoneAuth extends StatelessWidget {
  const PhoneAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text("Passer"),
                )
              ],
            ),
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
                    width: 50,
                    height: 50,
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
              onChanged: (value) {},
              title: const Text(
                  "Le lorem ipsum est, en imprimerie, une suite de mots sans "
                  "signification utilisée à titre provisoire pour calibrer une"
                  " mise en page, le texte définitif venant remplacer"),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 70,
              padding: const EdgeInsets.all(8.0),
              child: CButton(
                onPressed: () => Get.off(() => const HomePage()),
                child: const Text(
                  "CONNEXION",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                  "Le lorem ipsum est, en imprimerie, une suite de mots sans "
                  "signification utilisée à titre provisoire pour calibrer une"
                  " mise en page, le texte définitif venant remplacer"),
            ),
          ],
        ),
      ),
    );
  }
}
