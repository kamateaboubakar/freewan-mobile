import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import '../../job_views.dart';

class ApplyJobDescriptionPage extends StatefulWidget {
  const ApplyJobDescriptionPage({Key? key}) : super(key: key);

  @override
  State<ApplyJobDescriptionPage> createState() => _ApplyJobDescriptionPageState();
}

class _ApplyJobDescriptionPageState extends State<ApplyJobDescriptionPage> {
  JobOfferAppliedController _jobOfferAppliedController = Get.put(JobOfferAppliedController());

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
                            company: _applyJob!.jobOffer!.company!,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _applyJob.jobOffer!.label!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                _applyJob.jobOffer!.company!.name!,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                _applyJob.jobOffer!.expectedSalary!.formatAmount,
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
                                    title: _applyJob.jobOffer!.contractType?.label ??
                                        'Temps plein',
                                    fontSize: 9,
                                  )),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: JobTag(
                                      title: _applyJob.jobOffer!.activitySector?.label ??
                                          "A distance",
                                      fontSize: 9,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                      child: JobTag(
                                    title: _applyJob.jobOffer!.country?.label ?? "Senior",
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
                                _jobOfferAppliedController.updateDescriptionTabIndex(0);
                              },
                              child: Container(
                                color:
                                _jobOfferAppliedController.isDescriptionTabSelected
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
                                _jobOfferAppliedController.updateDescriptionTabIndex(1);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color:
                                _jobOfferAppliedController.isEntrepriseTabSelected
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
                      var tabIndex = _jobOfferAppliedController.descriptionTabIndex;
                      if (tabIndex == 0) {
                        return JobDescription();
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
                text: _applyJob.jobOffer!.description!,
                style: TextStyle(
                  color: AssetColors.grey3,
                ),
              ),
            ]),
      ),
    );
  }

  Widget ApplicationDescription() {
    return SingleChildScrollView(
      child: Column(
        children: [

          RichText(
            text: TextSpan(
                style: TextStyle(
                  color: AssetColors.grey3,
                  fontFamily: Const.defaultFont.fontFamily,
                ),
                children: [
                  TextSpan(
                    text: "Lettre de motivation",
                    style: TextStyle(
                      color: AssetColors.grey2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "${_applyJob.motivationLetter ?? 'Pas de lettre de motivation'}",
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
