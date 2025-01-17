import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favour_adminpanel/features/shop/categories/model/category_model.dart';
import 'package:favour_adminpanel/utilis/exceptors/firebase_exceptors.dart';
import 'package:favour_adminpanel/utilis/exceptors/platform_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepositories extends GetxController {
  static CategoryRepositories get instance => Get.find();

  // Firebase Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all categories from the 'Categories' colection
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("category").get();
      final result = snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

}