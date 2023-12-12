import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/models/pays.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/job/category.dart';
import 'package:wan_mobile/models/job/contract_type.dart';
import 'package:wan_mobile/models/job/job_offer.dart';
import 'package:wan_mobile/models/job/work_experience.dart';

import 'package:wan_mobile/views/controllers/job/add_job_vctl.dart';

import '../../../../../models/job/jobs_sector.dart';
import '../../job_views.dart';

class AddJobOfferInformationPage extends StatelessWidget {
  final JobOffer? jobOffer;

  const AddJobOfferInformationPage({this.jobOffer, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddJobController>(
        init: AddJobController(jobOffer),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              title: const Text("Mon offre"),
            ),
            body: Form(
              key: ctl.formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
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
                    const SizedBox(height: 15),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CTextFormField(
                              controller: ctl.jobTitleCtrl,
                              hintText: "Titre du poste",
                              require: true,
                              onChanged: (value) {
                                ctl.updateJobTitle(value);
                              },
                            ),
                            const SizedBox(height: 10),
                            CDropdownField<Pays>(
                              labelText: "Pays",
                              require: true,
                              asyncItems: (e) => ctl.getPays(),
                              selectedItem: ctl.selectedPays,
                              itemAsString: (e) => e.label.value,
                              onChanged: (pays) {
                                ctl.selectedPays = pays;
                                ctl.update();
                              },
                            ),
                            const SizedBox(height: 10),
                            CDropdownField<WorkExperience>(
                              labelText: "Expérience",
                              require: true,
                              asyncItems: (e) => ctl.getWorkExperiences(),
                              itemAsString: (e) => e.label.value,
                              selectedItem: ctl.selectedWorkExperience,
                              onChanged: (workExperience) {
                                ctl.selectedWorkExperience = workExperience;
                                ctl.update();
                              },
                            ),
                            const SizedBox(height: 10),
                            CDropdownField<JobCategory>(
                              labelText: "Catégorie",
                              require: true,
                              asyncItems: (e) => ctl.getJobCategories(),
                              selectedItem: ctl.selectedJobCategory,
                              itemAsString: (e) => e.label.value,
                              onChanged: (jobCategorie) {
                                ctl.selectedJobCategory = jobCategorie;
                                ctl.update();
                              },
                            ),
                            const SizedBox(height: 10),
                            CDropdownField<JobSector>(
                              labelText: "Secteur d'activité",
                              require: true,
                              asyncItems: (e) => ctl.getJobSectors(),
                              itemAsString: (e) => e.label.value,
                              selectedItem: ctl.selectedSector,
                              onChanged: (jobSector) {
                                ctl.selectedJobSector = jobSector;
                                ctl.update();
                              },
                            ),
                            const SizedBox(height: 10),
                            CDropdownField<ContractType>(
                              labelText: "Type",
                              require: true,
                              asyncItems: (e) => ctl.getContractTypes(),
                              selectedItem: ctl.selectedContractType,
                              itemAsString: (e) => e.label.value,
                              onChanged: (contractType) {
                                ctl.selectedContractType = contractType;
                                ctl.update();
                              },
                            ),
                            const SizedBox(height: 10),
                            CTextFormField(
                              controller: ctl.jobPlaceCtrl,
                              labelText: "Lieu",
                              require: true,
                              onChanged: (value) {
                                ctl.addJob!.workPlace = value;
                                ctl.update();
                              },
                            ),
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 0),
                              leading: Checkbox(
                                value: ctl.isRemoteJob,
                                onChanged: (value) {
                                  ctl.isRemoteJob = value!;
                                  ctl.update();
                                },
                                checkColor:
                                    const Color.fromRGBO(229, 229, 229, 1),
                              ),
                              title: const Text(
                                'A distance',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CButton(
                      height: 50,
                      onPressed: ctl.submit,
                      color: AssetColors.blueButton,
                      child: const Text(
                        "Continuer",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                    // GetBuilder(
                    //   init: _addJobController,
                    //   builder: (controller) {
                    //     _addJobController = controller;
                    //     return CButton(
                    //       height: 50,
                    //       onPressed: () {
                    //         if (_addJobController.isJobInfoValid) {
                    //           Get.to(const AddJobOfferDescriptionPage());
                    //         }
                    //       },
                    //       color: _addJobController.isJobInfoValid
                    //           ? AssetColors.blueButton
                    //           : const Color(0xffEDF2F9),
                    //       child: Text(
                    //         "Continuer",
                    //         style: TextStyle(
                    //           color: _addJobController.isJobInfoValid
                    //               ? Colors.white
                    //               : const Color(0xffB5C4D8),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
