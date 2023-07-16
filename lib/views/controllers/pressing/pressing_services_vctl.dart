import 'package:wan_mobile/api/controllers/pressing_api_ctl.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/models/pressing/pressing_service.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

import '../../../api/services/location_service.dart';
import '../../../models/location_model.dart';
import '../../../tools/utils/http_response.dart';

class PressingServiceController extends ViewController {
  final PressingApiCtl _pressingApiCtl = PressingApiCtl();

  HttpResponse<List<PressingService>>? _response;

  HttpResponse<List<PressingService>>? get response => _response;

  List<PressingService>? _pressingServices;

  List<PressingService>? get pressingServices => _pressingServices;

  List<PressingService> _selectedServices = [];

  List<PressingService> get selectedServices => _selectedServices;

  bool get hasSelectedServices => _selectedServices.isNotEmpty;

  updateSelectedService(PressingService service) {
    if (isSelected(service)) {
      _deleteSelectedService(service);
      update();
      return;
    }
    _selectedServices.add(service);
    update();
  }

  reset() {
    _response = null;
    _pressingServices = [];
  }

  getPressingServices(int pressingId) async {
    _response = null;
    update();
    _response =
        await _pressingApiCtl.getPressingServices(pressingId: pressingId);
    if (response!.status) {
      _pressingServices = response!.data!;
    }
    update();
  }

  bool isSelected(PressingService service) {
    return _selectedServices
        .where((element) => element.id! == service.id!)
        .isNotEmpty;
  }

  void _deleteSelectedService(PressingService service) {
    _selectedServices.removeWhere((element) => element.id == service.id);
  }
}
