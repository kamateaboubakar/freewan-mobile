import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wan_mobile/tools/utils/amount_util.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/job/company_logo.dart';
import 'package:wan_mobile/views/controllers/job/job_list_vctl.dart';
import 'package:wan_mobile/views/controllers/job/job_offer_applied_vctl.dart';
import 'package:wan_mobile/views/static/job/views/employee/employee_views.dart';
import 'package:wan_mobile/views/static/job/views/employer/add_job_offer_information_page.dart';

import '../../../../../models/job/apply_job.dart';
import '../../../../../models/job/job_offer.dart';
import '../../../../../tools/const/const.dart';
import '../../../../../tools/widgets/c_button.dart';
import '../../../../../tools/widgets/job/job_header.dart';
import '../../job_views.dart';

class ApplyJobDescriptionPage extends StatefulWidget {
  const ApplyJobDescriptionPage({Key? key}) : super(key: key);

  @override
  State<ApplyJobDescriptionPage> createState() =>
      _ApplyJobDescriptionPageState();
}

class _ApplyJobDescriptionPageState extends State<ApplyJobDescriptionPage> {
  JobOfferAppliedController _jobOfferAppliedController =
      Get.put(JobOfferAppliedController());

  late ApplyJob _applyJob;

  @override
  void initState() {
    _applyJob = _jobOfferAppliedController.applyJob!;
    _jobOfferAppliedController.resetDescriptionTabIndex();
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
                  JobHeader(jobOffer: _applyJob.jobOffer!),
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Obx(() {
                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _jobOfferAppliedController
                                    .updateDescriptionTabIndex(0);
                              },
                              child: Container(
                                color: _jobOfferAppliedController
                                        .isDescriptionTabSelected
                                    ? AssetColors.blueButton
                                    : AssetColors.lightGrey2,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  'Description',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _jobOfferAppliedController
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
                                _jobOfferAppliedController
                                    .updateDescriptionTabIndex(1);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color: _jobOfferAppliedController
                                        .isEntrepriseTabSelected
                                    ? AssetColors.blueButton
                                    : AssetColors.lightGrey2,
                                child: Text(
                                  'Candidature',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _jobOfferAppliedController
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
                      var tabIndex =
                          _jobOfferAppliedController.descriptionTabIndex;
                      if (tabIndex == 0) {
                        return JobDescription(jobOffer: _applyJob.jobOffer!);
                      }
                      return ApplicationDescription();
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget ApplicationDescription() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                style: TextStyle(
                  color: AssetColors.grey3,
                  fontFamily: Const.defaultFont.fontFamily,
                ),
                children: [
                  TextSpan(
                    text: "CV joint:\n",
                    style: TextStyle(
                      color: AssetColors.grey2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_applyJob.cvUrl != null && _applyJob.cvUrl!.isNotEmpty)
                    WidgetSpan(
                      child: InkWell(
                        onTap: () {
                          launchUrl(Uri.parse(_applyJob.cvUrl!),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Text(
                          "Cliquer ici pour voir",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  TextSpan(
                    text: "\n\nLettre de motivation\n",
                    style: TextStyle(
                      color: AssetColors.grey2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "${_applyJob.motivationLetter ?? 'Pas de lettre de motivation'}",
                    style: TextStyle(
                      color: AssetColors.grey3,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
