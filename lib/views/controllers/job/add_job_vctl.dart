import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/contract_type_api_ctrl.dart';
import 'package:wan_mobile/api/controllers/file_api_ctl.dart';
import 'package:wan_mobile/api/controllers/job_api_ctl.dart';
import 'package:wan_mobile/api/controllers/job_category_api_ctrl.dart';
import 'package:wan_mobile/api/controllers/job_sector_api_ctl.dart';
import 'package:wan_mobile/api/controllers/pays_api_ctl.dart';
import 'package:wan_mobile/api/controllers/work_experience_api_ctrl.dart';
import 'package:wan_mobile/models/job/category.dart';
import 'package:wan_mobile/models/job/job_offer.dart';
import 'package:wan_mobile/models/job/work_experience.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/utils/file_util.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

import '../../../api/controllers/company_api_ctl.dart';
import '../../../models/job/add_job.dart';
import '../../../models/job/company.dart';
import '../../../models/job/contract_type.dart';
import '../../../models/job/jobs_sector.dart';

class AddJobController extends ViewController {
  final JobApiCtrl _jobApiCtrl = JobApiCtrl();
  final ContractTypeApiCtl _contractTypeApiCtl = ContractTypeApiCtl();
  final JobSectorApiCtrl _jobSectorApiCtl = JobSectorApiCtrl();
  final CompanyApiCtl _companyApiCtrl = CompanyApiCtl();
  final PaysApiCtl _paysApiCtl = PaysApiCtl();
  final FileApiCtl _uploadFileCtl = FileApiCtl();
  final WorkExperienceApiCtl _workExperienceCtl = WorkExperienceApiCtl();
  final JobCategoryApiCtl _jobCategoryCtl = JobCategoryApiCtl();

  late AddJob _addJob;
  late Company _newCompany;

  Rx<bool> _isNewCompany = false.obs;

  bool get isNewCompany => _isNewCompany.value;

  Rx<bool> _isRemoteJob = false.obs;

  bool get isRemoteJob => _isRemoteJob.value;

  updateRemoteJobState(bool state) {
    _isRemoteJob.value = state;
  }

  File? _logoFile;

  File? get logoFile => _logoFile;

  int get selectedPaysPhoneNumberLength => _selectedPays!.phoneNumberLength!;

  bool _forJobUpdate = false;

  initJobInfo({JobOffer? jobOffer}) {
    _forJobUpdate = jobOffer != null;
    _addJob = AddJob();
    initCompanyInfo();

    if (jobOffer == null) {
      _selectedJobSector = null;
      _selectedContractType = null;
      _selectedPays = null;
      _selectedCompany = null;
      _isNewCompany = false.obs;
      _logoFile = null;
      return;
    }

    _addJob.id = jobOffer.id!;
    _addJob.label = jobOffer.label!;
    _selectedPays = jobOffer.country;
    _selectedWorkExperience = jobOffer.workExperience;
    _selectedJobCategory = jobOffer.category;
    _selectedJobSector = jobOffer.activitySector;
    _selectedContractType = jobOffer.contractType;
    _addJob.workPlace = jobOffer.workPlace;
    _addJob.remote = jobOffer.remote;
    _isRemoteJob = Rx<bool>(_addJob.remote ?? false);
    _addJob.description = jobOffer.description;
    _addJob.prerequisites = jobOffer.prerequisites;
    _addJob.expectedSalary = jobOffer.expectedSalary;
    _selectedCompany = jobOffer.company;
  }

  void initCompanyInfo() {
    _newCompany = Company();
  }

  updateIsNewCompany(bool state) {
    _isNewCompany.value = state;
    updateAddJobCreationSubmitButtonState();
  }

  HttpResponse<List<JobSector>>? _jobSectorResponse;

  HttpResponse<List<JobSector>>? get jobSectorResponse => _jobSectorResponse;

  JobSector? _selectedJobSector;

  JobSector? get selectedSector => _selectedJobSector;

  HttpResponse<List<ContractType>>? _contractTypeResponse;

  HttpResponse<List<ContractType>>? get contractTypeResponse =>
      _contractTypeResponse;

  ContractType? _selectedContractType;

  HttpResponse<List<Pays>>? _paysResponse;

  HttpResponse<List<Pays>>? get paysResponse => _paysResponse;

  Pays? _selectedPays;

  Pays? get selectedPays => _selectedPays;

  HttpResponse<List<Company>>? _companyResponse;

  HttpResponse<List<Company>>? get companyResponse => _companyResponse;

  Company? _selectedCompany;

  getJobSectors() async {
    _jobSectorResponse = null;
    update(['add_job_sector']);
    _jobSectorResponse = await _jobSectorApiCtl.getJobSectors();
    update(['add_job_sector']);
  }

  getContractTypes() async {
    _contractTypeResponse = null;
    update(['add_job_contract_type']);
    _contractTypeResponse = await _contractTypeApiCtl.getContractTypes();
    update(['add_job_contract_type']);
  }

  getPays() async {
    _paysResponse = null;
    update(['add_job_pays']);
    _paysResponse = await _paysApiCtl.getAll();
    update(['add_job_pays']);
  }

  getCompanies() async {
    _companyResponse = null;
    update(['add_job_company']);
    _companyResponse = await _companyApiCtrl.getCompanies();
    update(['add_job_company']);
  }

  updateSelectedJobSector(JobSector jobSector) {
    _selectedJobSector = jobSector;
    update();
  }

  updateSelectedContractType(ContractType contractType) {
    _selectedContractType = contractType;
    update();
  }

  updateJobTitle(String value) {
    _addJob.label = value;
    update();
  }

  updateJobDescription(String value) {
    _addJob.description = value;
    update(['add_job_description_submit']);
  }

  updateSelectedPays(Pays pays) {
    _selectedPays = pays;
    update();
  }

  updateSelectedCompany(Company company) {
    _selectedCompany = company;
    updateAddJobCreationSubmitButtonState();
  }

  void updateWorkPlace(String value) {
    _addJob.workPlace = value;
    update();
  }

  bool get isJobInfoValid =>
      _addJob.label!.isNotEmpty &&
      _addJob.workPlace!.isNotEmpty &&
      _selectedContractType != null &&
      _selectedJobSector != null &&
      _selectedPays != null &&
      _selectedWorkExperience != null &&
      _selectedJobCategory != null;

  bool get isJobDescriptionValid =>
      _addJob.description!.isNotEmpty &&
      _addJob.expectedSalary!.isNotEmpty &&
      _addJob.prerequisites!.isNotEmpty;

  void updateJobSalary(String value) {
    _addJob.expectedSalary = value;
    update(['add_job_description_submit']);
  }

  Future<HttpResponse> submitJobOffer() async {
    late HttpResponse companyResponse;

    if (isNewCompany) {
      var fileUploadResponse =
          await _uploadFileCtl.uploadFileNew(files: [_logoFile!]);
      if (!fileUploadResponse.status) {
        return fileUploadResponse;
      }

      _newCompany.logo = fileUploadResponse.data!.filename!;
      _newCompany.customerAccountId = appCtl.user.accountId!;
      companyResponse = await _companyApiCtrl.createCompany(_newCompany);
      if (!companyResponse.status) {
        return companyResponse;
      }
    }

    _addJob.contractTypeId = _selectedContractType!.id!;
    _addJob.activitySectorId = _selectedJobSector!.id!;
    _addJob.companyId =
        isNewCompany ? companyResponse.data!.id : _selectedCompany!.id!;
    _addJob.countryId = _selectedPays!.id!;
    _addJob.workExperienceId = _selectedWorkExperience!.id!;
    _addJob.categoryId = _selectedJobCategory!.id!;
    _addJob.remote = _isRemoteJob.value;

    return _forJobUpdate
        ? _jobApiCtrl.updateJob(_addJob)
        : _jobApiCtrl.addJob(_addJob);
  }

  void updateCompanyName(String value) {
    _newCompany.name = value;
    updateAddJobCreationSubmitButtonState();
  }

  void updateAddJobCreationSubmitButtonState() {
    update(['add_job_creation_submit']);
  }

  bool get isCompanyInfoValid {
    if (isNewCompany) {
      var verification1 = _newCompany.hasInformationFilled;
      var verification2 = _isNewCompanyPhoneValid;
      var verification3 = isCompanyLogoPicked;
      return verification1 && verification2 && verification3;
    }
    bool isInfoValid = _selectedCompany != null;
    return isInfoValid;
  }

  bool get isCompanyLogoPicked => _logoFile != null;

  void updateSelectedCompanySectorId(int id) {
    _newCompany.activitySectorId = id;
    updateAddJobCreationSubmitButtonState();
  }

  void updateCompanyEmail(String value) {
    _newCompany.email = value;
    updateAddJobCreationSubmitButtonState();
  }

  void updateCompanyLegalForm(String value) {
    _newCompany.legalForm = value;
    updateAddJobCreationSubmitButtonState();
  }

  void updateCompanyAddress(String value) {
    _newCompany.address = value;
    updateAddJobCreationSubmitButtonState();
  }

  void updateCompanyPhoneNumber(String value) {
    String countryPrexif = _selectedPays!.callingCode!;
    _newCompany.phoneNumber = countryPrexif + value;
    updateAddJobCreationSubmitButtonState();
  }

  bool get _isNewCompanyPhoneValid {
    return _newCompany.phoneNumber!.length ==
        (_selectedPays!.callingCode!.length +
            _selectedPays!.phoneNumberLength!);
  }

  void updateCompanyLogo(File file) {
    _logoFile = file;
    updateAddJobCreationSubmitButtonState();
  }

  HttpResponse<List<WorkExperience>>? _workExperienceResponse;

  HttpResponse<List<WorkExperience>>? get workExperienceResponse =>
      _workExperienceResponse;

  WorkExperience? _selectedWorkExperience;

  WorkExperience? get selectedWorkExperience => _selectedWorkExperience;

  void getWorkExperiences() async {
    _workExperienceResponse = null;
    update(['add_work_experience']);
    _workExperienceResponse = await _workExperienceCtl.getWorkExperiences();
    update(['add_work_experience']);
  }

  updateSelectedWorkExperience(WorkExperience workExperience) {
    _selectedWorkExperience = workExperience;
    update();
  }

  HttpResponse<List<JobCategory>>? _jobCategoryResponse;

  HttpResponse<List<JobCategory>>? get jobCategoryResponse =>
      _jobCategoryResponse;

  JobCategory? _selectedJobCategory;

  ContractType? get selectedContractType => _selectedContractType;

  getJobCategories() async {
    _jobCategoryResponse = null;
    update(['add_job_category']);
    _jobCategoryResponse = await _jobCategoryCtl.getJobCategory();
    update(['add_job_category']);
  }

  updateSelectedJobCategory(JobCategory jobCategory) {
    _selectedJobCategory = jobCategory;
    update();
  }

  void updatePrerequesite(String value) {
    _addJob.prerequisites = value;
    update(['add_job_description_submit']);
  }

  Company? get selectedCompany => _selectedCompany;

  JobCategory? get selectedJobCategory => _selectedJobCategory;

  AddJob get addJob => _addJob;

  bool get forJobUpdate => _forJobUpdate;

  void updateCompanyDescription(String value) {
    _newCompany.description = value;
    updateAddJobCreationSubmitButtonState();
  }
}
