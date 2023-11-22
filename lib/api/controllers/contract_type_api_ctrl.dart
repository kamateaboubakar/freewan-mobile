import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';

import 'package:wan_mobile/models/job/contract_type.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';

import '../../tools/const/const.dart';

class ContractTypeApiCtl {
  Future<HttpResponse<List<ContractType>>> getContractTypes() async {
    try {
      var url = "${Const.jobBaseUrl}/contract-types";
      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => ContractType.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
