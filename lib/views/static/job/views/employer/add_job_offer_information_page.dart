import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

import '../../../../../tools/widgets/c_button.dart';
import '../../../../../tools/widgets/c_dropdown_field.dart';
import '../../../../../tools/widgets/c_textform_field.dart';
import '../../job_views.dart';
import 'employer_views.dart';

class AddJobOfferInformationPage extends StatefulWidget {
  const AddJobOfferInformationPage({Key? key}) : super(key: key);

  @override
  State<AddJobOfferInformationPage> createState() =>
      _AddJobOfferInformationPageState();
}

class _AddJobOfferInformationPageState
    extends State<AddJobOfferInformationPage> {
  bool isOfferAdded = false;

  final TextEditingController _jobTitleCtrl = TextEditingController();
  final TextEditingController _jobPlaceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Mon offre"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'Informations du\nposte',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                LinearProgressStepper(
                  progress: 0.25,
                )
              ],
            ),
            SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CTextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _jobTitleCtrl,
                      hintText: "Titre du poste *",
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 5),
                    CDropdownField<String>(
                      labelText: "Catégorie *",
                      items: ["Software Engineering", "Design"],
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 5),
                    CDropdownField<String>(
                      labelText: "Expérience *",
                      items: ["> 3 years", "< 3 years"],
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 5),
                    CDropdownField<String>(
                      labelText: "Type *",
                      items: ["Part-Time", "Full-Time"],
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 5),
                    CTextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _jobPlaceCtrl,
                      hintText: "Lieu *",
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 5),
                    CDropdownField<String>(
                      labelText: "A distance/Sur site *",
                      items: ["A distance", "Sur site"],
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            CButton(
              onPressed: () => Get.to(AddJobOfferDescriptionPage()),
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
