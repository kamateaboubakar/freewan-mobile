import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';
import 'package:wan_mobile/models/app_notification.dart';

class NotificationApiCtl {
  static String module = "auth-center/api/v1/notifications";
  static Future<HttpResponse<List<AppNotification>>> getNotifications() async {
    try {
      var res = await WebRequest.nativRequest(
        AppHttpHeaders.baseUrl(module: "$module/userNotifications"),
        headers: AppHttpHeaders.authHeaders,
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

  static Future<HttpResponse<bool>> setRead(int notificationId) async {
    try {
      var response = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.PUT,
        AppHttpHeaders.baseUrl(module: "$module/setRead/$notificationId"),
        headers: AppHttpHeaders.authHeaders,
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
