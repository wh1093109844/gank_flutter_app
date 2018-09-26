import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileTools {
  static Future<File> getFile(String fileName) async {
    Directory dir = await getTemporaryDirectory();
    File file = File('${dir.path}${fileName}');
    return file;
  }

  static Future<File> getOrSaveFile(String fileName, String content) async {
    File file = await getFile(fileName);
    bool exists = await file.exists();
    if (exists) {
      return file;
    } else {
      return file.writeAsString(content);
    }
  }
}


