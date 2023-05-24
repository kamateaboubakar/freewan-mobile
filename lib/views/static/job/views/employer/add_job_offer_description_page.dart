import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/controllers/job/add_job_vctl.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';
import 'package:wan_mobile/views/static/job/views/employer/add_job_offer_company_page.dart';

import '../../../../../tools/utils/asset_colors.dart';
import '../../../../../tools/utils/tools.dart';
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

  AddJobController _addJobController = Get.put(AddJobController());

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
                      onChanged: (value) {
                        _addJobController.updateJobDescription(value);
                      },
                      maxLines: 5,
                    ),
                    /*const SizedBox(height: 5),
                    CTextFormField(
                      controller: _preRequesiteCtrl,
                      hintText: "Pré-requis *",
                      onChanged: (value) {},
                      maxLines: 5,
                    ),*/
                    const SizedBox(height: 5),
                    CTextFormField(
                      controller: _salaryCtrl,
                      hintText: "Salaire *",
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        _addJobController.updateJobSalary(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            GetBuilder(
              id: 'add_job_description_submit',
              init: _addJobController,
              builder: (controller) {
                return CButton(
                  height: 50,
                  onPressed: () {
                    if (_addJobController.isJobDescriptionValid) {
                      _addJob();
                    }
                  },
                  color: _addJobController.isJobDescriptionValid
                      ? AssetColors.blueButton
                      : const Color(0xffEDF2F9),
                  child: Text(
                    "Continuer",
                    style: TextStyle(
                      color: _addJobController.isJobDescriptionValid
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

  void _addJob() async {
    var pr = Tools.progressDialog();
    pr.show();
    var response = await _addJobController.addJobOffer();
    Get.back();
    if (!response.status) {
      Tools.messageBox(message: response.message);
      return;
    }
    Tools.messageBox(
        message: response.message,
        onConfirm: () {
          Get.offAll(HomePage());
        });
  }
}
