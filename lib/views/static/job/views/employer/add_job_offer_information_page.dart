import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/job/company.dart';
import 'package:wan_mobile/models/job/contract_type.dart';
import 'package:wan_mobile/views/controllers/job/add_job_vctl.dart';

import '../../../../../models/job/jobs_sector.dart';
import '../../../../../models/pays.dart';
import '../../../../../tools/utils/asset_colors.dart';
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

  AddJobController _addJobController = Get.put(AddJobController());

  @override
  void initState() {
    _addJobController.initJobInfo();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getJobSectors();
      _getContractTypes();
      _getPays();
    });
  }

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
                      controller: _jobTitleCtrl,
                      hintText: "Titre du poste *",
                      onChanged: (value) {
                        _addJobController.updateJobTitle(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    GetBuilder(
                        id: 'add_job_pays',
                        init: _addJobController,
                        builder: (controller) {
                          _addJobController = controller;
                          var response = controller.paysResponse;

                          if (response == null) {
                            return const Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          if (!response.status) {
                            return Center(
                              child: InkWell(
                                onTap: () {
                                  _getPays();
                                },
                                child: Icon(Icons.refresh),
                              ),
                            );
                          }

                          var pays = response.data!;
                          return CDropdownField<Pays>(
                            labelText: "Pays *",
                            items: pays,
                            backgroundColor: Colors.white,
                            itemBuilder: (pays) => Text(pays.label!),
                            selectedItemBuilder: (pays) {
                              return Text(pays.label ?? '');
                            },
                            onChanged: (pays) {
                              _addJobController.updateSelectedPays(pays!);
                            },
                          );
                        }),
                    const SizedBox(height: 10),
                    GetBuilder(
                        id: 'add_job_sector',
                        init: _addJobController,
                        builder: (controller) {
                          _addJobController = controller;
                          var response = controller.jobSectorResponse;

                          if (response == null) {
                            return const Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          if (!response.status) {
                            return Center(
                              child: InkWell(
                                onTap: () {
                                  _getJobSectors();
                                },
                                child: Icon(Icons.refresh),
                              ),
                            );
                          }

                          var jobSectors = response.data!;

                          return CDropdownField<JobSector>(
                            labelText: "Catégorie *",
                            items: jobSectors,
                            backgroundColor: Colors.white,
                            itemBuilder: (jobSector) => Text(jobSector.label!),
                            selectedItemBuilder: (jobSector) {
                              return Text(jobSector.label ?? '');
                            },
                            onChanged: (jobSector) {
                              _addJobController
                                  .updateSelectedJobSector(jobSector!);
                            },
                          );
                        }),
                    /*const CDropdownField<String>(
                      labelText: "Expérience *",
                      items: ["> 3 years", "< 3 years"],
                      backgroundColor: Colors.white,
                    ),*/
                    const SizedBox(height: 10),
                    GetBuilder(
                        id: 'add_job_contract_type',
                        init: _addJobController,
                        builder: (controller) {
                          _addJobController = controller;
                          var response = controller.contractTypeResponse;

                          if (response == null) {
                            return const Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          if (!response.status) {
                            return Center(
                              child: InkWell(
                                onTap: () {
                                  _getContractTypes();
                                },
                                child: Icon(Icons.refresh),
                              ),
                            );
                          }

                          var contractTypes = response.data!;
                          return CDropdownField<ContractType>(
                            labelText: "Type *",
                            items: contractTypes,
                            itemBuilder: (contractType) =>
                                Text(contractType.label!),
                            selectedItemBuilder: (contractType) {
                              return Text(contractType.label ?? '');
                            },
                            backgroundColor: Colors.white,
                            onChanged: (contractType) {
                              _addJobController
                                  .updateSelectedContractType(contractType!);
                            },
                          );
                        }),
                    const SizedBox(height: 10),
                    CTextFormField(
                      controller: _jobPlaceCtrl,
                      hintText: "Lieu *",
                      onChanged: (value) {
                        _addJobController.updateWorkPlace(value);
                      },
                    ),
                    /*const SizedBox(height: 10),
                    const CDropdownField<String>(
                      labelText: "A distance/Sur site *",
                      items: ["A distance", "Sur site"],
                      backgroundColor: Colors.white,
                    ),*/
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            GetBuilder(
              init: _addJobController,
              builder: (controller) {
                _addJobController = controller;
                return CButton(
                  height: 50,
                  onPressed: () {
                    if (_addJobController.isJobInfoValid) {
                      Get.to(const AddJobOfferDescriptionPage());
                    }
                  },
                  color: _addJobController.isJobInfoValid
                      ? AssetColors.blueButton
                      : const Color(0xffEDF2F9),
                  child: Text(
                    "Continuer",
                    style: TextStyle(
                      color: _addJobController.isJobInfoValid
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

  _getJobSectors() {
    _addJobController.getJobSectors();
  }

  _getContractTypes() {
    _addJobController.getContractTypes();
  }

  _getPays() {
    _addJobController.getPays();
  }
}
