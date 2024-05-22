import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageHandle {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<Uint8List?> getFileData(String path) async {
    final reference = storage.ref().child(path);
    final bytes = await reference.getData();
    return bytes;
  }
}
