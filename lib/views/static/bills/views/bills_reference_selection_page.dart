import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bills_views.dart';
import 'bills_list_page.dart';

class BillsReferenceSelectionPage extends StatelessWidget {
  const BillsReferenceSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Choix du compteur"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                tileColor: const Color.fromRGBO(237, 242, 249, 1),
                title: const Text(
                  "Payer pour ce compteur",
                  style: TextStyle(
                    color: Color.fromRGBO(72, 76, 79, 1),
                    fontSize: 15,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Image.asset(
                      "assets/images/cie.png",
                      width: 45,
                      height: 45,
                    ),
                    Text(
                      "144545266",
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Color.fromRGBO(7, 21, 60, 1),
                ),
                onTap: () => Get.to(BillsListPage()),
              ),
            ),
            AddAccountButton(
              title: "Payer pour un autre compteur",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
