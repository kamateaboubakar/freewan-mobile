import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/job/job_offer.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/job/apply_job_vctl.dart';
import 'package:wan_mobile/views/controllers/job/job_list_vctl.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

import '../../../../../tools/widgets/c_button.dart';
import '../../../../../tools/widgets/c_textform_field.dart';

class JobApplicationPage extends StatefulWidget {
  const JobApplicationPage({Key? key}) : super(key: key);

  @override
  State<JobApplicationPage> createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends State<JobApplicationPage> {
  final TextEditingController _coverLetterCtrl = TextEditingController();
  final JobListController _jobListController = Get.put(JobListController());
  ApplyJobController _applyJobController = Get.put(ApplyJobController());

  late JobOffer _jobOffer;

  @override
  void initState() {
    _jobOffer = _jobListController.jobOffer!;
    _applyJobController.initJobApplicationInfo();
    super.initState();
  }

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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Ecrivez votre lettre de motivation et télécharger votre CV",
                      style: TextStyle(fontSize: 14, color: AssetColors.blue),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CTextFormField(
                      controller: _coverLetterCtrl,
                      hintText: "Lettre de motivation *",
                      onChanged: (value) {
                        _applyJobController.updateCoverLetter(value);
                      },
                      maxLines: 5,
                    ),
                    const SizedBox(height: 5),
                    GetBuilder(
                        init: _applyJobController,
                        builder: (controller) {
                          _applyJobController = controller;
                          var isResumeUploaded =
                              _applyJobController.isResumePicked;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CTextFormField(
                                hintText: isResumeUploaded
                                    ? "CV ajouté"
                                    : "Sélection CV *",
                                onChanged: (value) {
                                  _pickFile();
                                },
                                readOnly: true,
                                fillColor: isResumeUploaded
                                    ? const Color(0xff14B53A)
                                    : Colors.white,
                                onTap: () {
                                  _pickFile();
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
                              if (isResumeUploaded) ...[
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          _applyJobController.resumeFilename),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _applyJobController.removeResumeFile();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.red),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                       padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Supprimer',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10)
                              ]
                            ],
                          );
                        }),
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
            const SizedBox(height: 10),
            GetBuilder(
              init: _applyJobController,
              builder: (controller) {
                _applyJobController = controller;
                return CButton(
                  height: 50,
                  onPressed: () {
                    if (_applyJobController.isJobApplicationInfoValid) {
                      _submitJobApplication();
                    }
                  },
                  color: _applyJobController.isJobApplicationInfoValid
                      ? AssetColors.blueButton
                      : const Color(0xffEDF2F9),
                  child: Text(
                    "Envoyer",
                    style: TextStyle(
                      color: _applyJobController.isJobApplicationInfoValid
                          ? Colors.white
                          : const Color(0xffB5C4D8),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _submitJobApplication() async {
    var pr = Tools.progressDialog();
    pr.show();
    var response = await _applyJobController.submitJobApplication(_jobOffer);
    Get.back();
    if (!response.status) {
      Tools.messageBox(message: response.message);
      return;
    }
    Tools.messageBox(
        message: "Votre candidature a été soumise",
        onConfirm: () {
          Get.offAll(HomePage());
        });
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'docx'],
        allowMultiple: false);

    if (result != null) {
      File file = File(result.files.first.path!);
      _applyJobController.updateResumeFile(file);
    } else {
      // User canceled the picker
    }
  }
}
