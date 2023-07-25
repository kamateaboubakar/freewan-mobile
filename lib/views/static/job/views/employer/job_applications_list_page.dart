import 'package:flutter/material.dart';
import 'package:wan_mobile/models/job/apply_job.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/controllers/job/job_application_list_vctl.dart';
import 'package:wan_mobile/views/static/job/views/employee/application_job_description_page.dart';

import '../../../../../tools/widgets/error_view.dart';
import '../../../../controllers/job/job_offer_applied_vctl.dart';

class JobApplicationsListPage extends StatefulWidget {
  const JobApplicationsListPage({Key? key}) : super(key: key);

  @override
  State<JobApplicationsListPage> createState() =>
      _JobApplicationsListPageState();
}

class _JobApplicationsListPageState extends State<JobApplicationsListPage> {
  JobApplicationsListController _jobApplicationListController = Get.put(JobApplicationsListController());
  final JobOfferAppliedController _jobOfferAppliedController = Get.put(JobOfferAppliedController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getJobApplicationList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var isOfferAdded = true;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Candidatures"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder(
          init: _jobApplicationListController,
          builder: (controller) {
            _jobApplicationListController = controller;
            var response = controller.response;

            if (response == null) {
              return const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (!response.status) {
              return ErrorView(
                message: response.message,
                retry: () {
                  _getJobApplicationList();
                },
              );
            }

            var jobOffers = response.data ?? [];

            if (jobOffers.isEmpty) {
              return noOfferView(screenWidth);
            }

            return jobListView(jobOffers);
          },
        ),
      ),
    );
  }

  Widget noOfferView(double screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset("assets/images/no_offer.png", height: 200),
        const SizedBox(height: 10),
        const Text(
          'Aucune candidature',
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget jobListView(List<ApplyJob> jobOffers) {
    return ListView.separated(
      itemCount: jobOffers.length,
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) {
        var jobOffer = jobOffers[index];
        return InkWell(
          onTap: () {
            _jobOfferAppliedController.updateSelectedJobOffer(jobOffer);
            Get.to(const ApplicationJobDescriptionPage());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xffE5E5E5),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "#${index + 1}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AssetColors.blueButton,
                  ),
                ),
                Text(
                    jobOffer.applicantDetails!.fullName),
                Text("${jobOffer.applicantDetails!.email}"),
              ],
            ),
          ),
        );
      },
    );
  }

  _getJobApplicationList() {
    _jobApplicationListController.getJobApplicationList();
  }
}
