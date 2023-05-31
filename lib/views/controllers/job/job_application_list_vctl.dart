import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/gaz_api_ctl.dart';
import 'package:wan_mobile/api/controllers/job_api_ctl.dart';
import 'package:wan_mobile/api/services/location_service.dart';
import 'package:wan_mobile/models/gas_size.dart';
import 'package:wan_mobile/models/location_model.dart';
import 'package:wan_mobile/models/shop.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

import '../../../models/job/apply_job.dart';
import '../../../models/job/job_offer.dart';

class JobApplicationsListController extends ViewController {
  final JobApiCtrl _jobApiCtl = JobApiCtrl();

  HttpResponse<List<ApplyJob>>? _response;

  HttpResponse<List<ApplyJob>>? get response => _response;

  ApplyJob? _applyJob;

  ApplyJob? get applyJob => _applyJob;

  late JobOffer _jobOffer;

  JobOffer? get jobOffer => _jobOffer;

  updateSelectedJobOffer(JobOffer jobOffer) {
    _jobOffer = jobOffer;
  }

  getJobApplicationList() async {
    _response = null;
    update();
    _response = await _jobApiCtl.getJobApplications(_jobOffer.id!);
    update();
  }
}
