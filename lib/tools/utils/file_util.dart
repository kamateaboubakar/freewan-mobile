import 'dart:convert';
import 'dart:io';

extension FileUtil on File {
  String get toBase64 {
    List<int> imageBytes = readAsBytesSync();
    return base64Encode(imageBytes);
  }
}
