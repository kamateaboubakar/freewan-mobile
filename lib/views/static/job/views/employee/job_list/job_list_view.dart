import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/error_view.dart';
import 'package:wan_mobile/views/static/job/views/employee/employee_views.dart';

import '../../../../../controllers/job/job_list_vctl.dart';
import '../../../widgets/jobs_item.dart';

class JobListView extends StatefulWidget {
  const JobListView({Key? key}) : super(key: key);

  @override
  State<JobListView> createState() => _JobListViewState();
}

class _JobListViewState extends State<JobListView> {
  JobListController _jobListController = Get.put(JobListController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getJobOffers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _jobListController,
        builder: (controller) {
          _jobListController = controller;
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
                _getJobOffers();
              },
            );
          }

          var jobs = response.data!;

          if (jobs.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/icons/empty_folder.png",
                    width: 100,
                  ),
                  const SizedBox(height: 10),
                  const Text('Aucune offre'),
                ],
              ),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              var job = jobs[index];
              return JobItem(
                canDelete: false,
                jobEntity: job,
                onTap: () {
                  _jobListController.updateSelectedJobOffer(job);
                  _jobListController.updateAlreadySubmitApplicationState();
                  Get.to(const JobDescriptionPage());
                },
              );
            },
          );
        });
  }

  _getJobOffers() {
    _jobListController.getJobOffers();
  }
}
