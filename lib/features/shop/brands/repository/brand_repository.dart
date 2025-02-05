import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favour_adminpanel/features/shop/brands/model/brand_category_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../utilis/exceptors/firebase_exceptors.dart';
import '../../../../utilis/exceptors/format_exception.dart';
import '../../../../utilis/exceptors/platform_exception.dart';
import '../model/brand_model.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();


  /// Variables
  final _db = FirebaseFirestore.instance;


  /// Get all categories
  Future<List<BrandModel>> getAllBrands() async {
    try{

      final snapshot = await _db.collection("Brands").get();
      final result = snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "$e";
    }
  }


  /// Get Brands For Category
  Future<List<BrandCategoryModel>> getAllBrandsCategory() async {
    try{
      final brandCategoryQuery = await _db.collection("BrandCategory").get();
      final brandCategory = brandCategoryQuery.docs.map((doc) => BrandCategoryModel.fromSnapshot(doc)).toList();
      return brandCategory;
//      QuerySnapshot brandCategoryQuery = await _db.collection
//         ("BrandCategory").where("categoryId",isEqualTo: categoryId).get();
//
//       // Extract brandIds from the documents
//       List <String> brandIds = brandCategoryQuery.docs.map((doc) => doc ["brandId"] as String).toList();
//
//       final brandsQuery = await _db.collection("Brands").where(FieldPath.documentId, whereIn: brandIds).limit(2).get();
//
//       List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      //return brands;

    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "$e";
    }
  }

}