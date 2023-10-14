import 'package:wan_mobile/api/abstracts/request_verbe_enum.dart';
import 'package:wan_mobile/tools/types/types.dart';

class RequestBodyObject {
  final RequestVerbeEnum _verbe;
  final int? _port;
  final String? _service;

  RequestBodyObject(
      {RequestVerbeEnum verbe = RequestVerbeEnum.GET,
      int? port,
      String? service})
      : _service = service,
        _port = port,
        _verbe = verbe;

  dynamic toJson() => {
        "verbe": _verbe.name,
        "port": _port,
        "service": _service,
      }.parseToJson();
}
