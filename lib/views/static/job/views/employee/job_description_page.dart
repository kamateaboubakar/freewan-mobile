import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/amount_util.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/job/company_logo.dart';
import 'package:wan_mobile/views/controllers/job/add_job_vctl.dart';
import 'package:wan_mobile/views/controllers/job/apply_job_vctl.dart';
import 'package:wan_mobile/views/controllers/job/job_list_vctl.dart';
import 'package:wan_mobile/views/static/job/views/employee/employee_views.dart';
import 'package:wan_mobile/views/static/job/views/employer/add_job_offer_information_page.dart';

import '../../../../../models/job/job_offer.dart';
import '../../../../../tools/const/const.dart';
import '../../../../../tools/widgets/c_button.dart';
import '../../job_views.dart';

class JobDescriptionPage extends StatefulWidget {
  const JobDescriptionPage({Key? key}) : super(key: key);

  @override
  State<JobDescriptionPage> createState() => _JobDescriptionPageState();
}

class _JobDescriptionPageState extends State<JobDescriptionPage> {
  JobListController _jobListController = Get.put(JobListController());
  AddJobController _addJobController = Get.put(AddJobController());

  late JobOffer _jobOffer;
  bool _canEditPost = false;
  bool _isAlreadySubmitApplication = false;

  @override
  void initState() {
    _jobOffer = _jobListController.jobOffer!;
    _jobListController.resetDescriptionTabIndex();
    _canEditPost = _jobListController.canEditPost;
    _isAlreadySubmitApplication = _jobListController.isAleardySubmitApplication;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Détails de l’offre"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xff4F9D4D).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: CompanyLogo(
                            company: _jobOffer.company!,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _jobOffer.label!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                _jobOffer.company!.name!,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                _jobOffer.expectedSalary!.formatAmount,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                      child: JobTag(
                                    title: _jobOffer.contractType?.label ??
                                        'Temps plein',
                                    fontSize: 9,
                                  )),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: JobTag(
                                      title: _jobOffer.activitySector?.label ??
                                          "A distance",
                                      fontSize: 9,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                      child: JobTag(
                                    title: _jobOffer.country?.label ?? "Senior",
                                    fontSize: 9,
                                  )),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Obx(() {
                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _jobListController.updateDescriptionTabIndex(0);
                              },
                              child: Container(
                                color:
                                    _jobListController.isDescriptionTabSelected
                                        ? AssetColors.blueButton
                                        : AssetColors.lightGrey2,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  'Description',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _jobListController
                                            .isDescriptionTabSelected
                                        ? Colors.white
                                        : AssetColors.grey3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _jobListController.updateDescriptionTabIndex(1);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color:
                                    _jobListController.isEntrepriseTabSelected
                                        ? AssetColors.blueButton
                                        : AssetColors.lightGrey2,
                                child: Text(
                                  'Entreprise',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _jobListController
                                            .isEntrepriseTabSelected
                                        ? Colors.white
                                        : AssetColors.grey3,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Obx(() {
                      var tabIndex = _jobListController.descriptionTabIndex;
                      if (tabIndex == 0) {
                        return JobDescription();
                      }
                      return EntrepriseDescription();
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (!_isAlreadySubmitApplication) ...{
              CButton(
                onPressed: () {
                  if (_canEditPost) {
                    Get.to(AddJobOfferInformationPage());
                    return;
                  }
                  Get.to(JobApplicationPage());
                },
                height: 48,
                child: Text(
                  _canEditPost ? "Modifier" : "Postuler",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              )
            }
          ],
        ),
      ),
    );
  }

  Widget JobDescription() {
    return SingleChildScrollView(
      child: RichText(
        text: TextSpan(
            style: TextStyle(
              color: AssetColors.grey3,
              fontFamily: Const.defaultFont.fontFamily,
            ),
            children: [
              TextSpan(
                text: "Description de l'offre\n",
                style: TextStyle(
                  color: AssetColors.grey2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: _jobOffer.description,
                style: TextStyle(
                  color: AssetColors.grey3,
                ),
              ),
            ]),
      ),
    );
  }

  Widget EntrepriseDescription() {
    return SingleChildScrollView(
      child: RichText(
        text: TextSpan(
            style: TextStyle(
              color: AssetColors.grey3,
              fontFamily: Const.defaultFont.fontFamily,
            ),
            children: [
              TextSpan(
                text: "${_jobOffer.company!.name}\n",
                style: TextStyle(
                  color: AssetColors.grey2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "${_jobOffer.company!.address}\n",
                style: TextStyle(
                  color: AssetColors.grey3,
                ),
              ),
              TextSpan(
                text: "${_jobOffer.company!.legalForm}\n",
                style: TextStyle(
                  color: AssetColors.grey3,
                ),
              ),
              TextSpan(
                text: "${_jobOffer.company!.email}\n",
                style: TextStyle(
                  color: AssetColors.grey3,
                ),
              ),
            ]),
      ),
    );
  }
}
