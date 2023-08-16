import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:module_master/module_master.dart';

class RecevoirPaiement extends StatelessWidget {
  const RecevoirPaiement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AssetColors.blueButton,
      appBar: AppBar(
        title: const Text("Réception d’argent"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                children: [
                  const ListTile(
                    leading: Icon(
                      Icons.check_circle,
                    ),
                    title: Text("Faites scanner le qr code"),
                    trailing: Icon(
                      Icons.more_horiz_rounded,
                      color: Colors.black,
                    ),
                  ),
                  const Gap(30),
                  const Text("Utilisez Scan pour me payer"),
                  QrImageView(
                    data: 'KLD450',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const Gap(27),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text("ID: KLD450"),
                        const Spacer(),
                        TextButton.icon(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                              AssetColors.blueButton,
                            ),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.copy),
                          label: const Text("Copier ID"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
