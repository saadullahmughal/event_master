import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FireStoreStorage {
  late FirebaseFirestore firestore = FirebaseFirestore.instance;
  late FirebaseStorage storage = FirebaseStorage.instance;

  String usersCollection = "users";
  bool isError = false;
  String errorMsg = '';

  late String userID, userName;

  Future<void> reset() async {
    errorMsg = '';
    isError = false;
  }

  Future<bool> userExists(String user) async {
    QuerySnapshot snap = await firestore
        .collection(usersCollection)
        .where('user', isEqualTo: user)
        .get();
    return snap.size != 0;
  }

  Future<int> authenticate(String user, String password) async {
    int result = 0;
    QuerySnapshot fetchedData = await firestore
        .collection(usersCollection)
        .where('user', isEqualTo: user)
        .where('pass_hash',
            isEqualTo: sha256.convert(password.codeUnits).toString())
        .get();
    for (var element in fetchedData.docs) {
      userID = user;
      userName = element.get('name');
      if (element.get('admin')) {
        result = 1;
      } else {
        result = 2;
      }
    }
    return result;
  }

  Future<void> createUser(
      String user, String name, String password, XFile? image) async {
    await storage.ref().child('profile_pics/$user').putFile(File(image!.path));
    await firestore.collection(usersCollection).add({
      "user": user,
      "pass_hash": sha256.convert(password.codeUnits).toString(),
      "name": name,
      "admin": false,
      "img_type": image!.path.substring(image!.path.lastIndexOf('.') + 1),
    });
  }
}
