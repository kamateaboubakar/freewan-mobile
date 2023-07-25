class FileUploadResult {
  String? code;
  String? message;
  String? filename;
  String? url;

  FileUploadResult({this.code, this.message, this.filename, this.url});

  FileUploadResult.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    filename = json['filename'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['filename'] = filename;
    data['url'] = url;
    return data;
  }
}
