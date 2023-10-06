import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/app_notification.dart';
import 'package:wan_mobile/tools/types/types.dart';

import '../../../tools/utils/http_response.dart';

class NotificationApiCtl extends WebController {
  Future<HttpResponse<List<AppNotification>>> getNotifications() async {
    try {
      var res = await get(
        HttpClientConst.baseUrl(module: "notifications/userNotifications"),
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data["data"] as List)
                .map((e) => AppNotification.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<bool>> setRead(int notificationId) async {
    try {
      var response = await put(
        HttpClientConst.baseUrl(
            module: "notifications/setRead/$notificationId"),
        {}.parseToJson(),
        headers: HttpClientConst.authHeaders,
      );

      var body = HttpResponse.decodeBody(response);
      if (body.status) {
        return HttpResponse.success(data: true);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
