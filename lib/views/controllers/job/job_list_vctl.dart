import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/api/controllers/job_api_ctl.dart';
import 'package:wan_mobile/models/job/jobs_sector.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';

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
    return _jobOffer!.company!.customerAccountId == appCtl.user.id!;
  }

  JobSector? _selectedJobCategory;

  JobSector? get selectedJobCategory => _selectedJobCategory;

  resetSelectedJobCategory() {
    _selectedJobCategory = null;
  }

  updateSelectedJobCategory(JobSector category) {
    _selectedJobCategory = category;
  }

  updateAlreadySubmitApplicationState([bool state = false]) {
    _isAleardySubmitApplication = state;
  }

  getJobOffers() async {
    _response = null;
    update();
    _response = _selectedJobCategory == null
        ? (await _jobApiCtl.getAllJobs())
        : (await _jobApiCtl.getAllJobByCategory(_selectedJobCategory!.id!));
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
