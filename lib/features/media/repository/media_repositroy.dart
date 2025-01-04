import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favour_adminpanel/features/media/model/image_model.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  // Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload any Image using File
  Future<ImageModel> uploadImageFileInStorage({
    required Uint8List file,
    required String path,
    required String imageName,
  }) async {
    try {
      // Reference to the storage location
      final Reference ref = _storage.ref('$path/$imageName');

      // Initialize content type and debug logging
      String contentType = 'application/octet-stream'; // Default fallback
      print('Uploading image: $imageName');

      // Check file extensions and set content type accordingly
      if (imageName.endsWith('.jpg') || imageName.endsWith('.jpeg')) {
        contentType = 'image/jpeg';
      } else if (imageName.endsWith('.png')) {
        contentType = 'image/png';
      } else if (imageName.endsWith('.gif')) {
        contentType = 'image/gif';
      } else if (imageName.endsWith('.bmp')) {
        contentType = 'image/bmp';
      } else if (imageName.endsWith('.webp')) {
        contentType = 'image/webp';
      } else {
        print('Unknown file type for image: $imageName, using default content type');
      }

      // Log the determined content type for debugging
      print('Using content type: $contentType');

      // Upload file with content type metadata
      await ref.putData(
        file,
        SettableMetadata(contentType: contentType),
      );

      // Get download URL
      final String downloadURL = await ref.getDownloadURL();

      // Fetch metadata
      final FullMetadata metadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetadata(
        metadata,
        path,
        imageName,
        downloadURL,
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }



  // Upload Image data in Firestore
  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection("Images")
          .add(image.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fetch Images from FireStore based on media category and loa count
  Future<List<ImageModel>> fetchImagesDatabase(
      MediaCategory mediaCategory, int loadCount) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Images")
          .where("mediaCategory", isEqualTo: mediaCategory.name.toString())
          .orderBy("createdAt", descending: true)
          .limit(loadCount)
          .get();

      // Debug log
      for (var doc in querySnapshot.docs) {
        print("Fetched Doc: ${doc.data()}");
      }

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }


  // Load more Images from FireStore based on media category, end last fetched date
  Future<List<ImageModel>> loadMoreImageFromDatabase(MediaCategory mediaCategory, int loadCount, DateTime lastFetchDate) async {
try{
  final querySnapshot = await FirebaseFirestore.instance
      .collection("Images").where("mediaCategory",isEqualTo: mediaCategory.name.toString())
      .orderBy("createdAt",descending: true).startAfter([lastFetchDate])
  .limit(loadCount).get();

  return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();

} on FirebaseException catch (e) {
  throw e.message!;
} on SocketException catch (e) {
  throw e.message;
} on PlatformException catch (e) {
  throw e.message!;
} catch (e) {
  throw e.toString();
}
  }

  // Delete file from Firebase Storage and corresponding document from Firestore
  Future<void> deleteFromStorage(ImageModel image) async {
    try {

      await FirebaseStorage.instance.ref(image.fullPath).delete();
      await FirebaseFirestore.instance.collection("Images").doc(image.id).delete();

    }  on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
