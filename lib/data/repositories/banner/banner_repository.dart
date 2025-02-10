import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/banners/model/banner_model.dart';
import '../../../utilis/exceptors/firebase_exceptors.dart';
import '../../../utilis/exceptors/format_exception.dart';
import '../../../utilis/exceptors/platform_exception.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all order related to current User
  Future<List<BannerModel>> getAllBanners() async {
    try {
      final snapshot = await _db.collection("banners").get();
      final result =
          snapshot.docs.map((e) => BannerModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong while fetching Banners. $e";
    }
  }

  /// Create a new banner in FireStore
  Future<String> CreateBanner(BannerModel banner) async {
    try {
      final result = await _db.collection("banners").add(banner.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong while fetching Banners. $e";
    }
  }

  /// Updating existing banner
  Future<void> UpdateBanner(BannerModel banner) async {
    try {
      await _db.collection("banners").doc(banner.id).update(banner.toJson());
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong while fetching Banners. $e";
    }
  }

  /// Delete a banner from FireStore
  Future<void> deleteBanner(String bannerId) async {
    try {
      await _db.collection("banners").doc(bannerId).delete();
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong while fetching Banners. $e";
    }
  }

  /// Upload Banners to the Cloud Firebase
  ///  Future<void> uploadDummyData(List<BannerModel> banners) async {
//     try {
//       // upload all the Categories along with their Images
//       final storage = Get.put(fFirebaseStorageService());
//
//       // Loop through each category
//       for (var banner in banners) {
//         // Get ImageData line from the local assets
//         final file = await storage.getImageDataFromAssets(banner.imageUrl);
//
//         // Upload Image and Get Its URL
//         final url = await storage.uploadImageData("Banner", file, banner.targetScreen);
//
//         // Assign URL to Category image attribute
//         banner.imageUrl = url;
//
//         // Store Category in FireStore
//         await _db.collection("Banner").where("Active,isEqualto = true").where(banner.imageUrl).get(banner.toJson() as GetOptions?);
//       }
//     } on FirebaseException catch (e) {
//       throw fFirebaseException(e.code).message;
//     } on PlatformException catch  (e) {
//       throw fPlatformException(e.code).message;
//     } catch (e) {
//       throw "Something went wrong. Please try again";
//     }
//   }}
}
