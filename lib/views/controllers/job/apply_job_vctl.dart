import 'dart:io';

import 'package:wan_mobile/api/controllers/file_api_ctl.dart';
import 'package:wan_mobile/api/controllers/job_api_ctl.dart';
import 'package:wan_mobile/models/job/apply_job.dart';
import 'package:wan_mobile/models/job/job_offer.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';
import 'package:path/path.dart' as p;

class ApplyJobController extends ViewController {
  final JobApiCtrl _jobApiCtrl = JobApiCtrl();
  final FileApiCtl _uploadFileCtl = FileApiCtl();

  late ApplyJob _applyJob;

  File? _resumeFile;

  void initJobApplicationInfo() {
    _applyJob = ApplyJob();
    _resumeFile = null;
  }

  updateCoverLetter(String value) {
    _applyJob.motivationLetter = value;
    update();
  }

  updateResumeFile(File file) {
    _resumeFile = file;
    update();
  }

  bool get isJobApplicationInfoValid =>
      _applyJob.motivationLetter!.isNotEmpty && isResumePicked;

  bool get isResumePicked => _resumeFile != null;

  String get resumeFilename => p.basename(_resumeFile!.path);

  Future<HttpResponse> submitJobApplication(JobOffer offer) async {
    var fileUploadResponse =
        await _uploadFileCtl.uploadFileNew(files: [_resumeFile!]);
    if (!fileUploadResponse.status) {
      return fileUploadResponse;
    }
    _applyJob.cvFilename = fileUploadResponse.data!.filename!;
    _applyJob.customerAccountId = appCtl.user.id.value.toString();
    return _jobApiCtrl.applyToJob(applyJob: _applyJob, jobOffer: offer);
  }

  void removeResumeFile() {
    _resumeFile = null;
    update();
  }
}
