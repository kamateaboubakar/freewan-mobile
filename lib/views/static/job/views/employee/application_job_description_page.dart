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

class ApplicationJobDescriptionPage extends StatefulWidget {
  const ApplicationJobDescriptionPage({Key? key}) : super(key: key);

  @override
  State<ApplicationJobDescriptionPage> createState() =>
      _ApplicationJobDescriptionPageState();
}

class _ApplicationJobDescriptionPageState
    extends State<ApplicationJobDescriptionPage> {
  JobOfferAppliedController _jobOfferAppliedController =
      Get.put(JobOfferAppliedController());

  late ApplyJob _applyJob;

  @override
  void initState() {
    _applyJob = _jobOfferAppliedController.applyJob!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Détails de la candidature"),
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
                  Expanded(
                    child: ApplicationDescription(),
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
                    text: "Nom & Prénoms:\n",
                    style: TextStyle(
                      color: AssetColors.grey2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: _applyJob.applicantDetails!.fullName,
                    style: TextStyle(
                      color: AssetColors.grey3,
                    ),
                  ),
                  TextSpan(
                    text: "\n\nEmail:\n",
                    style: TextStyle(
                      color: AssetColors.grey2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: _applyJob.applicantDetails!.email,
                    style: TextStyle(
                      color: AssetColors.grey3,
                    ),
                  ),
                  TextSpan(
                    text: "\n\nCV joint:\n",
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
