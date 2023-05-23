import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/static/job/views/employer/add_job_offer_company_page.dart';

import '../../../../../tools/widgets/c_button.dart';
import '../../../../../tools/widgets/c_textform_field.dart';
import '../../job_views.dart';

class AddJobOfferDescriptionPage extends StatefulWidget {
  const AddJobOfferDescriptionPage({Key? key}) : super(key: key);

  @override
  State<AddJobOfferDescriptionPage> createState() =>
      _AddJobOfferDescriptionPageState();
}

class _AddJobOfferDescriptionPageState
    extends State<AddJobOfferDescriptionPage> {
  final TextEditingController _descriptionCtrl = TextEditingController();
  final TextEditingController _preRequesiteCtrl = TextEditingController();
  final TextEditingController _salaryCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Mon offre"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: const [
                Text(
                  'Informations du\nposte',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                LinearProgressStepper(
                  progress: 0.5,
                )
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CTextFormField(
                      controller: _descriptionCtrl,
                      hintText: "Description *",
                      onChanged: (value) {},
                      maxLines: 5,
                    ),
                    const SizedBox(height: 5),
                    CTextFormField(
                      controller: _preRequesiteCtrl,
                      hintText: "Pré-requis *",
                      onChanged: (value) {},
                      maxLines: 5,
                    ),
                    const SizedBox(height: 5),
                    CTextFormField(
                      controller: _salaryCtrl,
                      hintText: "Salaire *",
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            CButton(
              onPressed: () => Get.to(const AddJobOfferCompanyPage()),
              height: 48,
              child: const Text(
                "Continuer",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
