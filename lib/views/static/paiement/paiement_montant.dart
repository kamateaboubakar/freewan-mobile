import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/paiement/paiement_montant_vctl.dart';

class PaiementMontant extends StatelessWidget {
  final User receiver;
  final String route;
  const PaiementMontant(this.route, {required this.receiver, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaiementMontantVctl>(
        init: PaiementMontantVctl(receiver.id!, route),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: const Text("Montant"),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 50,
                width: Get.width,
                child: CButton(
                  height: 48,
                  minWidth: 149,
                  borderRadius: 8,
                  onPressed: ctl.submit,
                  child: const Text(
                    "Payer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: ctl.montantCtl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 63),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "0 Fcfa",
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
