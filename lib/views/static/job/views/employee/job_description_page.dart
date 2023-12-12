import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:tools_flutter_project/widgets/c_button.dart';
import 'package:wan_mobile/views/controllers/job/job_list_vctl.dart';
import 'package:wan_mobile/views/static/job/views/employee/employee_views.dart';
import 'package:wan_mobile/views/static/job/views/employer/add_job_offer_information_page.dart';

import '../../../../../models/job/job_offer.dart';
import '../../../../../tools/const/const.dart';
import '../../../../../tools/widgets/c_outlined_button.dart';
import '../../../../../tools/widgets/job/job_header.dart';
import '../../../../controllers/job/job_application_list_vctl.dart';
import '../employer/job_applications_list_page.dart';

class JobDescriptionPage extends StatefulWidget {
  const JobDescriptionPage({Key? key}) : super(key: key);

  @override
  State<JobDescriptionPage> createState() => _JobDescriptionPageState();
}

class _JobDescriptionPageState extends State<JobDescriptionPage> {
  final JobListController _jobListController = Get.put(JobListController());
  final JobApplicationsListController _jobApplicationListController =
      Get.put(JobApplicationsListController());

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
                  JobHeader(jobOffer: _jobOffer),
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
                        return JobDescription(jobOffer: _jobOffer);
                      }
                      return EntrepriseDescription();
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (!_isAlreadySubmitApplication)
              Row(
                children: [
                  Expanded(
                    child: CButton(
                      onPressed: () {
                        if (_canEditPost) {
                          Get.to(
                            AddJobOfferInformationPage(
                              jobOffer: _jobOffer,
                            ),
                          );
                          return;
                        }
                        Get.to(const JobApplicationPage());
                      },
                      height: 48,
                      child: Text(
                        _canEditPost ? "Modifier" : "Postuler",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if (_canEditPost) ...[
                    const SizedBox(width: 10),
                    Expanded(
                      child: COutlinedButton(
                        onPressed: () {
                          _jobApplicationListController
                              .updateSelectedJobOffer(_jobOffer);
                          Get.to(const JobApplicationsListPage());
                        },
                        height: 48,
                        child: const Text(
                          "Voir candidatures",
                          style: TextStyle(
                            fontSize: 16,
                            color: AssetColors.blueButton,
                          ),
                        ),
                      ),
                    )
                  ]
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget EntrepriseDescription() {
    return SingleChildScrollView(
      child: RichText(
        text: TextSpan(
            style: TextStyle(
              color: AssetColors.grey3,
              fontFamily: Const.defaultFont,
            ),
            children: [
              TextSpan(
                text: "${_jobOffer.company!.name}\n",
                style: const TextStyle(
                  color: AssetColors.grey2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "${_jobOffer.company!.address}\n",
                style: const TextStyle(
                  color: AssetColors.grey3,
                ),
              ),
              TextSpan(
                text: "${_jobOffer.company!.legalForm}\n",
                style: const TextStyle(
                  color: AssetColors.grey3,
                ),
              ),
              TextSpan(
                text: "${_jobOffer.company!.email}\n",
                style: const TextStyle(
                  color: AssetColors.grey3,
                ),
              ),
            ]),
      ),
    );
  }
}

class JobDescription extends StatelessWidget {
  final JobOffer jobOffer;

  const JobDescription({
    Key? key,
    required this.jobOffer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: RichText(
        text: TextSpan(
            style: TextStyle(
              color: AssetColors.grey3,
              fontFamily: Const.defaultFont,
            ),
            children: [
              const TextSpan(
                text: "Description de l'offre\n",
                style: TextStyle(
                  color: AssetColors.grey2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: jobOffer.description,
                style: const TextStyle(
                  color: AssetColors.grey3,
                ),
              ),
              const TextSpan(
                text: "\n\nPré-requis\n",
                style: TextStyle(
                  color: AssetColors.grey2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: jobOffer.prerequisites,
                style: const TextStyle(
                  color: AssetColors.grey3,
                ),
              ),
            ]),
      ),
    );
  }
}
