import 'package:get/get.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:wan_mobile/api/controllers/job_api_ctl.dart';

import 'package:tools_flutter_project/tools/http/http_response.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';

import '../../../models/job/apply_job.dart';

class JobOfferAppliedController extends ViewController {
  final JobApiCtrl _jobApiCtl = JobApiCtrl();

  HttpResponse<List<ApplyJob>>? _response;

  HttpResponse<List<ApplyJob>>? get response => _response;

  ApplyJob? _applyJob;

  ApplyJob? get applyJob => _applyJob;

  getJobOffersApplied() async {
    _response = null;
    update();
    _response = await _jobApiCtl.getJobApplied(appCtl.user.id.value.toString());
    update();
  }

  void updateSelectedJobOffer(ApplyJob jobOffer) {
    _applyJob = jobOffer;
  }

  final Rx<int> _descriptionTabIndex = 0.obs;

  int get descriptionTabIndex => _descriptionTabIndex.value;

  bool get isDescriptionTabSelected => _descriptionTabIndex.value == 0;

  bool get isEntrepriseTabSelected => _descriptionTabIndex.value == 1;

  void resetDescriptionTabIndex() {
    _descriptionTabIndex.value = 0;
  }

  updateDescriptionTabIndex(int value) {
    _descriptionTabIndex.value = value;
  }
}
