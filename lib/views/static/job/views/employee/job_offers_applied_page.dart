import 'package:flutter/material.dart';
import 'package:wan_mobile/models/job/apply_job.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/controllers/job/job_list_vctl.dart';
import 'package:wan_mobile/views/static/job/views/employee/apply_job_description_page.dart';

import '../../../../../tools/widgets/error_view.dart';
import '../../../../controllers/job/job_offer_applied_vctl.dart';
import '../../job_views.dart';

class JobOffersAppliedPage extends StatefulWidget {
  const JobOffersAppliedPage({Key? key}) : super(key: key);

  @override
  State<JobOffersAppliedPage> createState() => _JobOffersAppliedPageState();
}

class _JobOffersAppliedPageState extends State<JobOffersAppliedPage> {
  JobOfferAppliedController _jobOfferAppliedController =
      Get.put(JobOfferAppliedController());
  final JobListController _jobListController = Get.put(JobListController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getJobOfferApplied();
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
        title: const Text("Mes candidatures"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder(
          init: _jobOfferAppliedController,
          builder: (controller) {
            _jobOfferAppliedController = controller;
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
                  _getJobOfferApplied();
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
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: jobOffers.length,
      itemBuilder: (context, index) {
        var jobOffer = jobOffers[index];
        return JobItem(
          jobEntity: jobOffer.jobOffer,
          canDelete: false,
          onTap: () {
            _jobOfferAppliedController.updateSelectedJobOffer(jobOffer);
            //_jobListController.updateAlreadySubmitApplicationState(true);
            //_jobListController.updateEditPostState();
            Get.to(const ApplyJobDescriptionPage());
          },
        );
      },
    );
  }

  _getJobOfferApplied() {
    _jobOfferAppliedController.getJobOffersApplied();
  }
}
