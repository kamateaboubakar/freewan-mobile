import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/static/tv_bills/tv_bills_forumla_list_page.dart';

class TvBillsAccountNumberPage extends StatelessWidget {
  final TextEditingController _referenceCtrl = TextEditingController();
  final String route;
  TvBillsAccountNumberPage({required this.route, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Abonnement Canalplus"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/Canal+1.png',
                      height: 50,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Entrez le numéro d’abonné de 14 chiffres',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    CTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      require: true,
                      controller: _referenceCtrl,
                      labelText: "Numéro d'exploitation",
                    ),
                  ],
                ),
              ),
            ),
            CButton(
              height: 50,
              onPressed: () => Get.to(
                () => TvBillsFormulaListPage(
                  newSubscription: false,
                  route: route,
                ),
              ),
              child: const Text("Confirmer"),
            ),
          ],
        ),
      ),
    );
  }
}
