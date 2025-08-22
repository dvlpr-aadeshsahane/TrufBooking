import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import '../../../core/const/globalObj.dart';

class TurfRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  TurfRepository({FirebaseFirestore? firestore, FirebaseStorage? storage})
    : firestore = firestore ?? FirebaseFirestore.instance,
      storage = storage ?? FirebaseStorage.instance;

  Future<List<String>> uploadCompressedImages(List<String> imagePaths) async {
    List<String> downloadUrls = [];

    for (String imagePath in imagePaths) {
      try {
        // Compress the image to WebP format
        final compressedBytes = await FlutterImageCompress.compressWithFile(
          imagePath,
          format: CompressFormat.webp,
          quality: 30, // 100 = best, 0 = worst, 30 = ~70% compressed
        );

        if (compressedBytes == null) {
          throw Exception("Compression failed for $imagePath");
        }

        // Create a temporary file to store compressed image
        final tempDir = Directory.systemTemp;
        final fileName = "${const Uuid().v4()}.webp";
        final tempFile = File(path.join(tempDir.path, fileName));
        await tempFile.writeAsBytes(compressedBytes);

        // Upload to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child(
          'uploads/$fileName',
        );
        final uploadTask = await storageRef.putFile(tempFile);
        final url = await uploadTask.ref.getDownloadURL();

        // Add to result list
        downloadUrls.add(url);

        // Optional: delete temp file after upload
        await tempFile.delete();
      } catch (e, s) {
        logger.e("COMPRESS AND UPLOAD IMAGE ERROR", error: e, stackTrace: s);
        rethrow;
      }
    }

    return downloadUrls;
  }

  Future<void> saveTurf({
    required String name,
    required String phone,
    required String description,
    required String price,
    required String imageUrl,
    required List sports,
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
