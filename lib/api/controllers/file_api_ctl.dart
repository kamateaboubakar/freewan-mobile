import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/file_upload_result.dart';
import 'package:wan_mobile/models/job/add_job.dart';
import 'package:wan_mobile/models/job/apply_job.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

import '../../models/job/job_offer.dart';
import '../../tools/const/const.dart';
import 'package:path/path.dart' as p;

class FileApiCtl extends WebController {
  Future<HttpResponse<FileUploadResult>> uploadFile(File file) async {
    try {
      var url = "${Const.jobBaseUrl}/files/upload";
      var filename = p.basename(file.path);
      print('file name $filename');
      final form = FormData({
        'file': MultipartFile(file, filename: filename),
      });

      var res = await post(
        url,
        form,
      );

      print(res.body);

      var body = HttpResponse.decodeBody(res);

      print(body.data);

      if (body.status) {
        return HttpResponse.success(
          data: FileUploadResult.fromJson(body.data),
        );
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
