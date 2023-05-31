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

class JobOfferAppliedController extends ViewController {
  final JobApiCtrl _jobApiCtl = JobApiCtrl();

  HttpResponse<List<ApplyJob>>? _response;

  HttpResponse<List<ApplyJob>>? get response => _response;

  ApplyJob? _applyJob;

  ApplyJob? get applyJob => _applyJob;

  getJobOffersApplied() async {
    _response = null;
    update();
    _response = await _jobApiCtl.getJobApplied(appCtl.user.accountId);
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
