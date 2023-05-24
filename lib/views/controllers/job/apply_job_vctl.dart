import 'dart:io';

import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/job_api_ctl.dart';
import 'package:wan_mobile/models/job/apply_job.dart';
import 'package:wan_mobile/models/job/job_offer.dart';
import 'package:wan_mobile/tools/utils/file_util.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class ApplyJobController extends ViewController {
  final JobApiCtrl _jobApiCtrl = JobApiCtrl();

  late ApplyJob _applyJob;

  File? _resumeFile;

  void initJobApplicationInfo() {
    _applyJob = ApplyJob();
    _resumeFile = null;
  }

  updateCoverLetter(String value) {
    _applyJob.coverLetter = value;
    update();
  }

  updateResumeFile(File file) {
    _resumeFile = file;
    update();
  }

  bool get isJobApplicationInfoValid =>
      _applyJob.coverLetter!.isNotEmpty && isResumePicked;

  bool get isResumePicked => _resumeFile != null;

  Future<HttpResponse> submitJobApplication(JobOffer offer) {
    _applyJob.resume = _resumeFile!.toBase64;
    _applyJob.customerAccountId = appCtl.user.accountId!;
    return _jobApiCtrl.applyToJob(applyJob: _applyJob, jobOffer: offer);
  }
}
