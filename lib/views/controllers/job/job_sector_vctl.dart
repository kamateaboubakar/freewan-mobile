import 'package:wan_mobile/api/controllers/job_api_ctl.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

import '../../../models/job/jobs_sector.dart';

class JobSectorController extends ViewController {
  final JobApiCtrl _jobApiCtl = JobApiCtrl();

  HttpResponse<List<JobSector>>? _response;

  HttpResponse<List<JobSector>>? get response => _response;

  JobSector? _jobSector;

  JobSector? get jobSector => _jobSector;

  getJobSectors() async {
    _response = null;
    update();
    _response = await _jobApiCtl.getJobSectors();
    if (response!.status) {
      _response!.data!.insert(0, JobSector(id: 0, label: 'Tous'));
      _jobSector = _response!.data!.first;
    }
    update();
  }

  void updateSelectedJobSector(JobSector jobSector) {
    _jobSector = jobSector;
    update();
  }
}
