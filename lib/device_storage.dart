import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class LocalStorage {
  Future<bool> saveProfilePic(Uint8List? bytes) async {
    bool success = false;
    if (bytes == null) {
      return success;
    }
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/profile_pic");
    await file.writeAsBytes(bytes);
    success = true;
    return success;
  }

  static Future<String> getDocDir() async {
    var dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
}
