import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/static/tv_bills/tv_bills_forumla_list_page.dart';

import '../../../../tools/widgets/c_button.dart';
import '../../../../tools/widgets/c_textform_field.dart';

class TvBillsAccountNumberPage extends StatelessWidget {
  final TextEditingController _referenceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Abonnement Canalplus"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                    SizedBox(height: 20),
                    Text(
                      'Entrez le numéro d’abonné de 14 chiffres',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
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
              onPressed: () => Get.to(TvBillsFormulaListPage(newSubscription: false)),
              child: const Text("Confirmer"),
            ),
          ],
        ),
      ),
    );
  }
}
