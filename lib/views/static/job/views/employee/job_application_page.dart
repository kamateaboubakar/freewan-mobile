import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

import '../../../../../tools/widgets/c_button.dart';
import '../../../../../tools/widgets/c_dropdown_field.dart';
import '../../../../../tools/widgets/c_textform_field.dart';
import '../../job_views.dart';

class JobApplicationPage extends StatefulWidget {
  const JobApplicationPage({Key? key}) : super(key: key);

  @override
  State<JobApplicationPage> createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends State<JobApplicationPage> {
  final TextEditingController _coverLetterCtrl = TextEditingController();

  bool isResumeUploaded = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Postulation"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Ecrivez votre lettre de motivation et télécharger votre CV",
                      style: TextStyle(
                        fontSize: 14,
                        color: AssetColors.blue
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    CTextFormField(
                      controller: _coverLetterCtrl,
                      hintText: "Lettre de motivation *",
                      onChanged: (value) {},
                      maxLines: 5,
                    ),
                    SizedBox(height: 5),
                    CTextFormField(
                      hintText: isResumeUploaded ? "CV ajouté" : "Sélection CV *",
                      onChanged: (value) {},
                      readOnly: true,
                      fillColor: isResumeUploaded ? Color(0xff14B53A) : Colors.white,
                      onTap: () {
                        setState(() {
                          isResumeUploaded = true;
                        });
                      },
                      suffixIcon: Icon(
                        isResumeUploaded ? Icons.check : Icons.add,
                        color: isResumeUploaded
                            ? Colors.white
                            : AssetColors.blueButton,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Pdf, Docx, Doc',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            CButton(
              onPressed: () {},
              height: 48,
              child: const Text(
                "Envoyer",
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
