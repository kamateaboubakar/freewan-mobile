import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:module_master/module_master.dart';
import 'package:wan_mobile/views/controllers/job/job_offer_applied_vctl.dart';
import '../../../../../models/job/apply_job.dart';
import '../../../../../tools/widgets/job/job_header.dart';

class ApplicationJobDescriptionPage extends StatefulWidget {
  const ApplicationJobDescriptionPage({Key? key}) : super(key: key);

  @override
  State<ApplicationJobDescriptionPage> createState() =>
      _ApplicationJobDescriptionPageState();
}

class _ApplicationJobDescriptionPageState
    extends State<ApplicationJobDescriptionPage> {
  final JobOfferAppliedController _jobOfferAppliedController =
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

  Widget ApplicationDescription() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                style: TextStyle(
                  color: AssetColors.grey3,
                  fontFamily: Const.defaultFont,
                ),
                children: [
                  const TextSpan(
                    text: "Nom & Prénoms:\n",
                    style: TextStyle(
                      color: AssetColors.grey2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: _applyJob.applicantDetails!.fullName,
                    style: const TextStyle(
                      color: AssetColors.grey3,
                    ),
                  ),
                  const TextSpan(
                    text: "\n\nEmail:\n",
                    style: TextStyle(
                      color: AssetColors.grey2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: _applyJob.applicantDetails!.email,
                    style: const TextStyle(
                      color: AssetColors.grey3,
                    ),
                  ),
                  const TextSpan(
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
                        child: const Text(
                          "Cliquer ici pour voir",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  const TextSpan(
                    text: "\n\nLettre de motivation\n",
                    style: TextStyle(
                      color: AssetColors.grey2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: _applyJob.motivationLetter ??
                        'Pas de lettre de motivation',
                    style: const TextStyle(
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
