import 'dart:io';

import 'package:wan_mobile/api/controllers/job_api_ctl.dart';
import 'package:wan_mobile/api/controllers/pays_api_ctl.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

import '../../../models/job/add_job.dart';
import '../../../models/job/company.dart';
import '../../../models/job/contract_type.dart';
import '../../../models/job/jobs_sector.dart';

class AddJobController extends ViewController {
  final JobApiCtrl _jobApiCtrl = JobApiCtrl();
  final PaysApiCtl _paysApiCtl = PaysApiCtl();

  late AddJob _addJob;


  initJobInfo() {
    _addJob = AddJob();
    _selectedJobSector = null;
    _selectedContractType = null;
    _selectedPays = null;
    _selectedCompany = null;
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

  HttpResponse<List<Company>>? _companyResponse;

  HttpResponse<List<Company>>? get companyResponse => _companyResponse;

  Company? _selectedCompany;

  getJobSectors() async {
    _jobSectorResponse = null;
    update(['add_job_sector']);
    _jobSectorResponse = await _jobApiCtrl.getJobSectors();
    update(['add_job_sector']);
  }

  getContractTypes() async {
    _contractTypeResponse = null;
    update(['add_job_contract_type']);
    _contractTypeResponse = await _jobApiCtrl.getContractTypes();
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
    _companyResponse = await _jobApiCtrl.getCompanies();
    update(['add_job_company']);
  }

  updateSelectedJobSector(JobSector jobSector) {
    print('jobSector ${jobSector.toJson()}');
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
    update();
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
      _selectedCompany != null;

  bool get isJobDescriptionValid =>
      _addJob.description!.isNotEmpty && _addJob.expectedSalary!.isNotEmpty;

  void updateJobSalary(String value) {
    _addJob.expectedSalary = value;
    update(['add_job_description_submit']);
  }

  Future<HttpResponse> addJobOffer() {
    _addJob.contractTypeId = _selectedContractType!.id!;
    _addJob.activitySectorId = _selectedJobSector!.id!;
    _addJob.companyId = _selectedCompany!.id!;
    _addJob.countryId = _selectedPays!.id!;
    return _jobApiCtrl.addJob(_addJob);
  }
}
