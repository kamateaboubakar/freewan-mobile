import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/gaz_api_ctl.dart';
import 'package:wan_mobile/api/controllers/job_api_ctl.dart';
import 'package:wan_mobile/api/services/location_service.dart';
import 'package:wan_mobile/models/gas_size.dart';
import 'package:wan_mobile/models/location_model.dart';
import 'package:wan_mobile/models/shop.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

import '../../../models/job/job_offer.dart';

class JobListController extends ViewController {
  final JobApiCtrl _jobApiCtl = JobApiCtrl();

  HttpResponse<List<JobOffer>>? _response;

  HttpResponse<List<JobOffer>>? get response => _response;

  JobOffer? _jobOffer;

  JobOffer? get jobOffer => _jobOffer;

  final Rx<int> _descriptionTabIndex = 0.obs;

  int get descriptionTabIndex => _descriptionTabIndex.value;

  bool get isDescriptionTabSelected => _descriptionTabIndex.value == 0;

  bool get isEntrepriseTabSelected => _descriptionTabIndex.value == 1;

  bool _isAleardySubmitApplication = false;

  bool get isAleardySubmitApplication => _isAleardySubmitApplication;

  bool get canEditPost {
    print('company customer ${_jobOffer!.company!.customerAccountId}');
    print('user customer ${appCtl.user.accountId!}');
    return _jobOffer!.company!.customerAccountId == appCtl.user.accountId!;
  }

  updateAlreadySubmitApplicationState([bool state = false]) {
    _isAleardySubmitApplication = state;
  }

  getJobOffers() async {
    _response = null;
    update();
    _response = await _jobApiCtl.getAllJobs();
    update();
  }

  void updateSelectedJobOffer(JobOffer jobOffer) {
    _jobOffer = jobOffer;
    update();
  }

  void resetDescriptionTabIndex() {
    _descriptionTabIndex.value = 0;
  }

  updateDescriptionTabIndex(int value) {
    _descriptionTabIndex.value = value;
  }
}