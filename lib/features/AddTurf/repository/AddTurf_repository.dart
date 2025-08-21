import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TurfRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  TurfRepository({FirebaseFirestore? firestore, FirebaseStorage? storage})
    : firestore = firestore ?? FirebaseFirestore.instance,
      storage = storage ?? FirebaseStorage.instance;

  Future<String> uploadTurfImage(File file) async {
    final String fileName =
        "turfs/${DateTime.now().millisecondsSinceEpoch}.jpg";
    final ref = storage.ref().child(fileName);

    UploadTask task = ref.putFile(file);
    TaskSnapshot snap = await task;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> saveTurf({
    required String name,
    required String phone,
    required String description,
    required String price,
    required String imageUrl,
    required List<String> sports,
  }) async {
    await firestore.collection("turfs").add({
      "turfName": name,
      "phone": phone,
      "description": description,
      "price": price,
      "imageUrl": imageUrl,
      "sports": sports,
      "createdAt": Timestamp.now().millisecondsSinceEpoch,
    });
  }
}
