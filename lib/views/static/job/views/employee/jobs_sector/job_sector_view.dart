import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/error_view.dart';
import 'package:wan_mobile/views/controllers/job/job_list_vctl.dart';
import 'package:wan_mobile/views/controllers/job/job_sector_vctl.dart';

import '../../../widgets/job_tag.dart';

class JobSectorView extends StatefulWidget {
  const JobSectorView({Key? key}) : super(key: key);

  @override
  State<JobSectorView> createState() => _JobSectorViewState();
}

class _JobSectorViewState extends State<JobSectorView> {
  JobSectorController _jobSectorController = Get.put(JobSectorController());
  final JobListController _jobListController = Get.put(JobListController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getJobSector();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _jobSectorController,
        builder: (controller) {
          _jobSectorController = controller;
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
                _getJobSector();
              },
            );
          }

          var jobSectors = response.data!;

          return ListView.separated(
              itemCount: jobSectors.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                var jobSector = jobSectors[index];
                var selected =
                    jobSector.id == _jobSectorController.jobSector?.id;
                return JobTag(
                  title: jobSector.label!,
                  fontSize: 16,
                  selected: selected,
                  onTap: () {
                    _jobSectorController.updateSelectedJobSector(jobSector);
                    if (jobSector.id == 0) {
                      _jobListController.resetSelectedJobCategory();
                    } else {
                      _jobListController.updateSelectedJobCategory(jobSector);
                    }
                    _jobListController.getJobOffers();
                  },
                );
              });
        });
  }

  _getJobSector() {
    _jobSectorController.getJobSectors();
  }
}
