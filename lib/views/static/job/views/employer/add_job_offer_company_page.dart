import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wan_mobile/models/job/job_offer.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/controllers/job/add_job_vctl.dart';

import '../../../../../models/job/company.dart';
import '../../../../../models/job/jobs_sector.dart';
import '../../../../../tools/utils/tools.dart';
import '../../../../../tools/widgets/c_button.dart';
import '../../../../../tools/widgets/c_dropdown_field.dart';
import '../../../../../tools/widgets/c_textform_field.dart';
import '../../../home/home_page.dart';
import '../../job_views.dart';

class AddJobOfferCompanyPage extends StatefulWidget {
  const AddJobOfferCompanyPage({Key? key}) : super(key: key);

  @override
  State<AddJobOfferCompanyPage> createState() => _AddJobOfferCompanyPageState();
}

class _AddJobOfferCompanyPageState extends State<AddJobOfferCompanyPage> {
  AddJobController _addJobController = Get.put(AddJobController(JobOffer()));

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _legalFormCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _phoneNumberCtrl = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCompanies();
    });
  }

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
                  progress: 0.75,
                )
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    GetBuilder(
                        id: 'add_job_company',
                        init: _addJobController,
                        builder: (controller) {
                          _addJobController = controller;
                          var response = controller.companyResponse;

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
                                  _getCompanies();
                                },
                                child: const Icon(Icons.refresh),
                              ),
                            );
                          }

                          var companies = response.data!;
                          return CDropdownField<Company>(
                            labelText: "Entreprise *",
                            items: companies,
                            selectedItem: _addJobController.selectedCompany,
                            backgroundColor: Colors.white,
                            itemBuilder: (company) {
                              return Text(company.name!);
                            },
                            selectedItemBuilder: (company) {
                              return Text(company.name ?? '');
                            },
                            onChanged: (company) {
                              _addJobController.updateSelectedCompany(company!);
                            },
                          );
                        }),
                    Obx(() {
                      bool isNewCompany = _addJobController.isNewCompany;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            leading: Checkbox(
                              value: isNewCompany,
                              onChanged: (value) {
                                _addJobController.updateIsNewCompany(value!);
                              },
                              checkColor:
                                  const Color.fromRGBO(229, 229, 229, 1),
                            ),
                            title: const Text(
                              'Ajouter une nouvelle entreprise',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 5),
                          if (isNewCompany) ...[
                            CTextFormField(
                              controller: _nameCtrl,
                              hintText: "Nom de l'entreprise *",
                              onChanged: (value) {
                                _addJobController.updateCompanyName(value);
                              },
                            ),
                            const SizedBox(height: 5),
                            CDropdownField<JobSector>(
                              labelText: "Catégorie *",
                              asyncItems: (e) =>
                                  _addJobController.getJobSectors(),
                              backgroundColor: Colors.white,
                              itemBuilder: (jobSector) =>
                                  Text(jobSector.label!),
                              selectedItemBuilder: (jobSector) {
                                return Text(jobSector.label ?? '');
                              },
                              onChanged: (jobSector) {
                                _addJobController.updateSelectedCompanySectorId(
                                    jobSector!.id!);
                              },
                            ),
                            const SizedBox(height: 5),
                            CTextFormField(
                              controller: _descriptionCtrl,
                              hintText: "Description *",
                              onChanged: (value) {
                                _addJobController
                                    .updateCompanyDescription(value);
                              },
                              maxLines: 5,
                            ),
                            const SizedBox(height: 5),
                            CTextFormField(
                              controller: _emailCtrl,
                              hintText: "Email *",
                              onChanged: (value) {
                                _addJobController.updateCompanyEmail(value);
                              },
                            ),
                            const SizedBox(height: 5),
                            CTextFormField(
                              controller: _legalFormCtrl,
                              hintText: "Forme juridique *",
                              onChanged: (value) {
                                _addJobController.updateCompanyLegalForm(value);
                              },
                            ),
                            const SizedBox(height: 5),
                            CTextFormField(
                              controller: _addressCtrl,
                              hintText: "Adresse *",
                              onChanged: (value) {
                                _addJobController.updateCompanyAddress(value);
                              },
                            ),
                            const SizedBox(height: 5),
                            CTextFormField(
                              controller: _phoneNumberCtrl,
                              hintText: "Numéro de téléphone*",
                              keyboardType: TextInputType.phone,
                              maxLength: _addJobController
                                  .selectedPaysPhoneNumberLength,
                              onChanged: (value) {
                                _addJobController
                                    .updateCompanyPhoneNumber(value);
                              },
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      _pickLogo();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: AssetColors.blueButton,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      child: const Stack(
                                        children: [
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
                                ),
                                GetBuilder(
                                  id: 'add_job_creation_submit',
                                  init: _addJobController,
                                  builder: (controller) {
                                    _addJobController = controller;
                                    File? logoFile = _addJobController.logoFile;

                                    if (logoFile == null) return Container();

                                    return Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        Image.file(logoFile,
                                            width: 50, height: 50),
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          ]
                        ],
                      );
                    })
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            GetBuilder(
              id: 'add_job_creation_submit',
              init: _addJobController,
              builder: (controller) {
                _addJobController = controller;
                return CButton(
                  height: 50,
                  onPressed: () {
                    if (_addJobController.isCompanyInfoValid) {
                      _addJob();
                    }
                  },
                  color: _addJobController.isCompanyInfoValid
                      ? AssetColors.blueButton
                      : const Color(0xffEDF2F9),
                  child: Text(
                    "Valider",
                    style: TextStyle(
                      color: _addJobController.isCompanyInfoValid
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
    var response = await _addJobController.submitJobOffer();
    Get.back();
    if (!response.status) {
      Tools.messageBox(message: response.message);
      return;
    }
    Tools.messageBox(
        message: _addJobController.forJobUpdate
            ? "Votre offre d'emploi a été modifiée"
            : "Votre offre d'emploi a été créée",
        onConfirm: () {
          Get.offAll(const HomePage());
        });
  }

  _getCompanies() {
    _addJobController.getCompanies();
  }

  void _pickLogo() async {
    final XFile? file =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      _addJobController.updateCompanyLogo(File(file.path));
    }
  }
}
