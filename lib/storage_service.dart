import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as fb_storage;
import 'package:firebase_core/firebase_core.dart' as fb_core;

class Storage {
  final fb_storage.FirebaseStorage storage =
      fb_storage.FirebaseStorage.instance;
  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await storage.ref('products/$fileName').putFile(file);
    } on fb_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<fb_storage.ListResult> listProducts() async {
    fb_storage.ListResult result = await storage.ref("products").listAll();
    result.items.forEach((fb_storage.Reference ref) {
      print("Found files: $ref");
    });
    return result;
  }

  Future<String> downloadUrl(String imageName) async {
    String downloadUrl =
        await storage.ref('products/$imageName').getDownloadURL();

    return downloadUrl;
  }
}
