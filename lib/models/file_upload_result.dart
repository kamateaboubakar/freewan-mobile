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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['filename'] = this.filename;
    data['url'] = this.url;
    return data;
  }
}
