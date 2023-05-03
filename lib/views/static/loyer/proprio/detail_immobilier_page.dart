import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/static/loyer/proprio/detail_appartement_page.dart';

class DetailImmobilierPage extends StatelessWidget {
  const DetailImmobilierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Résidences Samray"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Wrap(
            spacing: 10,
            children: [
              RawChip(
                selectedColor: const Color.fromRGBO(13, 51, 159, 1),
                checkmarkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
                label: const Text(
                  "Tout",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                selected: true,
                onPressed: () {},
              ),
              RawChip(
                selectedColor: const Color.fromRGBO(13, 51, 159, 1),
                label: const Text("Loyer payé"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {},
              ),
              RawChip(
                selectedColor: const Color.fromRGBO(13, 51, 159, 1),
                label: const Text("Loyer non payé"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {},
              ),
            ],
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(
                padding: const EdgeInsets.all(5),
                onPressed: () => Get.to(() => const DetailAppartementPage()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Image.asset(
                        "assets/images/icons/immeuble.png",
                        width: 45,
                        height: 65,
                      ),
                      title: const Text(
                        "Appartement A09",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      subtitle: const Text(
                        "Studio(80 000 FCFA)",
                        style: TextStyle(
                          color: Color.fromRGBO(123, 131, 160, 1),
                          fontSize: 13,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(220, 20, 60, 0.11),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        "Paiement était dû le 3 Mai 2023",
                        style: TextStyle(
                          color: Color.fromRGBO(206, 17, 38, 1),
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              MaterialButton(
                padding: const EdgeInsets.all(5),
                onPressed: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Image.asset(
                        "assets/images/icons/immeuble.png",
                        width: 45,
                        height: 65,
                      ),
                      title: const Text(
                        "Appartement A11",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      subtitle: const Text(
                        "Studio(80 000 FCFA)",
                        style: TextStyle(
                          color: Color.fromRGBO(123, 131, 160, 1),
                          fontSize: 13,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(226, 220, 255, 1),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        "Paiement dû le 5 Mai 2023",
                        style: TextStyle(
                          color: Color.fromRGBO(13, 51, 159, 1),
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              MaterialButton(
                padding: const EdgeInsets.all(5),
                onPressed: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Image.asset(
                        "assets/images/icons/immeuble.png",
                        width: 45,
                        height: 65,
                      ),
                      title: const Text(
                        "Appartement A11",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      subtitle: const Text(
                        "Studio(80 000 FCFA)",
                        style: TextStyle(
                          color: Color.fromRGBO(123, 131, 160, 1),
                          fontSize: 13,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(20, 181, 58, 0.28),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        "Loyer Payé",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 133, 63, 1),
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
