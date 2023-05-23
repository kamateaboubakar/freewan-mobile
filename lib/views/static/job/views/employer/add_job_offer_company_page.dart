import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

import '../../../../../tools/widgets/c_button.dart';
import '../../../../../tools/widgets/c_textform_field.dart';
import '../../job_views.dart';

class AddJobOfferCompanyPage extends StatefulWidget {
  const AddJobOfferCompanyPage({Key? key}) : super(key: key);

  @override
  State<AddJobOfferCompanyPage> createState() => _AddJobOfferCompanyPageState();
}

class _AddJobOfferCompanyPageState extends State<AddJobOfferCompanyPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
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
                  progress: 0.75,
                )
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CTextFormField(
                      controller: _nameCtrl,
                      hintText: "Nom de l'entreprise *",
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 5),
                    CTextFormField(
                      controller: _descriptionCtrl,
                      hintText: "Description *",
                      onChanged: (value) {},
                      maxLines: 5,
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: AssetColors.blueButton,
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Stack(
                          children: const [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.add,
                                color: AssetColors.blueButton,
                              ),
                            ),
                            Center(
                              child: Text(
                                "Ajouter logo",
                                style: TextStyle(
                                    color: AssetColors.blueButton,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            CButton(
              onPressed: () {},
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
