import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/models/pays.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
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

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';
import 'package:wan_mobile/views/static/job/views/employer/add_job_offer_description_page.dart';
import '../../../api/controllers/company_api_ctl.dart';
import '../../../models/job/add_job.dart';
import '../../../models/job/company.dart';
import '../../../models/job/contract_type.dart';
import '../../../models/job/jobs_sector.dart';

class AddJobController extends ViewController {
  JobOffer? jobOffer;
  final JobApiCtrl _jobApiCtrl = JobApiCtrl();
  final ContractTypeApiCtl _contractTypeApiCtl = ContractTypeApiCtl();
  final JobSectorApiCtrl _jobSectorApiCtl = JobSectorApiCtrl();
  final CompanyApiCtl _companyApiCtrl = CompanyApiCtl();
  final PaysApiCtl _paysApiCtl = PaysApiCtl();
  final FileApiCtl _uploadFileCtl = FileApiCtl();
  final WorkExperienceApiCtl _workExperienceCtl = WorkExperienceApiCtl();
  final JobCategoryApiCtl _jobCategoryCtl = JobCategoryApiCtl();

  final TextEditingController jobTitleCtrl = TextEditingController();
  final TextEditingController jobPlaceCtrl = TextEditingController();
  JobCategory? selectedJobCategory;
  bool forJobUpdate = false;
  bool isRemoteJob = false;

  var formKey = GlobalKey<FormState>();

  AddJob? addJob;
  Company? newCompany;
  Company? selectedCompany;

  AddJobController(this.jobOffer);

  Rx<bool> _isNewCompany = false.obs;

  bool get isNewCompany => _isNewCompany.value;

  File? _logoFile;

  File? get logoFile => _logoFile;

  int get selectedPaysPhoneNumberLength => selectedPays!.phoneNumberLength!;

  bool _forJobUpdate = false;

  initJobInfo({JobOffer? jobOffer}) {
    _forJobUpdate = jobOffer != null;
    addJob = AddJob();
    initCompanyInfo();

    if (jobOffer == null) {
      selectedJobSector = null;
      selectedContractType = null;
      selectedPays = null;
      _selectedCompany = null;
      _isNewCompany = false.obs;
      _logoFile = null;
      return;
    }

    addJob!.id = jobOffer.id!;
    addJob!.label = jobOffer.label!;
    selectedPays = jobOffer.country;
    selectedWorkExperience = jobOffer.workExperience;
    selectedJobCategory = jobOffer.category;
    selectedJobSector = jobOffer.activitySector;
    selectedContractType = jobOffer.contractType;
    addJob!.workPlace = jobOffer.workPlace;
    addJob!.remote = jobOffer.remote;
    isRemoteJob = addJob!.remote ?? false;
    addJob!.description = jobOffer.description;
    addJob!.prerequisites = jobOffer.prerequisites;
    addJob!.expectedSalary = jobOffer.expectedSalary;
    _selectedCompany = jobOffer.company;
  }

  void initCompanyInfo() {
    newCompany = Company();
  }

  updateIsNewCompany(bool state) {
    _isNewCompany.value = state;
    updateAddJobCreationSubmitButtonState();
  }

  JobSector? selectedJobSector;

  JobSector? get selectedSector => selectedJobSector;

  ContractType? selectedContractType;

  Pays? selectedPays;

  HttpResponse<List<Company>>? _companyResponse;

  HttpResponse<List<Company>>? get companyResponse => _companyResponse;

  Company? _selectedCompany;

  Future<List<JobSector>> getJobSectors() async {
    var res = await _jobSectorApiCtl.getJobSectors();
    if (res.status) {
      return res.data!;
    } else {
      return [];
    }
  }

  Future<List<ContractType>> getContractTypes() async {
    var res = await _contractTypeApiCtl.getContractTypes();
    if (res.status) {
      return res.data!;
    } else {
      return [];
    }
  }

  Future<List<Pays>> getPays() async {
    var res = await _paysApiCtl.getAll();
    if (res.status) {
      return res.data!;
    } else {
      return [];
    }
  }

  getCompanies() async {
    _companyResponse = null;
    update(['add_job_company']);
    _companyResponse = await _companyApiCtrl.getCompanies();
    update(['add_job_company']);
  }

  updateJobTitle(String value) {
    addJob!.label = value;
    update();
  }

  updateJobDescription(String value) {
    addJob!.description = value;
    update(['add_job_description_submit']);
  }

  updateSelectedCompany(Company company) {
    _selectedCompany = company;
    updateAddJobCreationSubmitButtonState();
  }

  bool get isJobDescriptionValid =>
      addJob!.description!.isNotEmpty &&
      addJob!.expectedSalary!.isNotEmpty &&
      addJob!.prerequisites!.isNotEmpty;

  void updateJobSalary(String value) {
    addJob!.expectedSalary = value;
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

      newCompany!.logo = fileUploadResponse.data!.filename!;
      newCompany!.customerAccountId = appCtl.user.id.value.toString();
      companyResponse = await _companyApiCtrl.createCompany(newCompany!);
      if (!companyResponse.status) {
        return companyResponse;
      }
    }

    addJob!.contractTypeId = selectedContractType!.id!;
    addJob!.activitySectorId = selectedJobSector!.id!;
    addJob!.companyId =
        isNewCompany ? companyResponse.data!.id : _selectedCompany!.id!;
    addJob!.countryId = selectedPays!.id!;
    addJob!.workExperienceId = selectedWorkExperience!.id!;
    addJob!.categoryId = selectedJobCategory!.id!;
    addJob!.remote = isRemoteJob;

    return _forJobUpdate
        ? _jobApiCtrl.updateJob(addJob!)
        : _jobApiCtrl.addJob(addJob!);
  }

  void updateCompanyName(String value) {
    newCompany!.name = value;
    updateAddJobCreationSubmitButtonState();
  }

  void updateAddJobCreationSubmitButtonState() {
    update(['add_job_creation_submit']);
  }

  bool get isCompanyInfoValid {
    if (isNewCompany) {
      var verification1 = newCompany!.hasInformationFilled;
      var verification2 = _isNewCompanyPhoneValid;
      var verification3 = isCompanyLogoPicked;
      return verification1 && verification2 && verification3;
    }
    bool isInfoValid = _selectedCompany != null;
    return isInfoValid;
  }

  bool get isCompanyLogoPicked => _logoFile != null;

  void updateSelectedCompanySectorId(int id) {
    newCompany!.activitySectorId = id;
    updateAddJobCreationSubmitButtonState();
  }

  void updateCompanyEmail(String value) {
    newCompany!.email = value;
    updateAddJobCreationSubmitButtonState();
  }

  void updateCompanyLegalForm(String value) {
    newCompany!.legalForm = value;
    updateAddJobCreationSubmitButtonState();
  }

  void updateCompanyAddress(String value) {
    newCompany!.address = value;
    updateAddJobCreationSubmitButtonState();
  }

  void updateCompanyPhoneNumber(String value) {
    String countryPrexif = selectedPays!.callingCode!;
    newCompany!.phoneNumber = countryPrexif + value;
    updateAddJobCreationSubmitButtonState();
  }

  bool get _isNewCompanyPhoneValid {
    return newCompany!.phoneNumber!.length ==
        (selectedPays!.callingCode!.length + selectedPays!.phoneNumberLength!);
  }

  void updateCompanyLogo(File file) {
    _logoFile = file;
    updateAddJobCreationSubmitButtonState();
  }

  WorkExperience? selectedWorkExperience;

  Future<List<WorkExperience>> getWorkExperiences() async {
    var res = await _workExperienceCtl.getWorkExperiences();
    if (res.status) {
      return res.data!;
    } else {
      return [];
    }
  }

  Future<List<JobCategory>> getJobCategories() async {
    var res = await _jobCategoryCtl.getJobCategory();
    if (res.status) {
      return res.data!;
    } else {
      return [];
    }
  }

  void updatePrerequesite(String value) {
    addJob!.prerequisites = value;
    update(['add_job_description_submit']);
  }

  void updateCompanyDescription(String value) {
    newCompany!.description = value;
    updateAddJobCreationSubmitButtonState();
  }

  @override
  void onReady() {
    super.onReady();
    initJobInfo(jobOffer: jobOffer);
    if (jobOffer != null) {
      jobTitleCtrl.text = jobOffer!.label!;
      jobPlaceCtrl.text = jobOffer!.workPlace!;
    }

    getJobSectors();
    getContractTypes();
    getPays();
    getWorkExperiences();
    getJobCategories();
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      Get.to(const AddJobOfferDescriptionPage());
    }
  }
}
