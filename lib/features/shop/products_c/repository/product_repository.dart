import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../utilis/exceptors/firebase_exceptors.dart';
import '../../../../utilis/exceptors/format_exception.dart';
import '../../../../utilis/exceptors/platform_exception.dart';
import '../all_products/model/product_category_model.dart';
import '../all_products/model/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// FireStore instance for database interaction
  final _db = FirebaseFirestore.instance;

  /* ----------------------- Function --------------------------------*/

  /// Create Product
  Future<String> createProduct(ProductModel product) async {
    try {
      final result = await _db.collection("Products").add(product.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong while fetching Products. $e";
    }
  }

  /// Create New Product Category
  Future<String> createProductCategory(
      ProductCategoryModel productCategory) async {
    try {
      final result =
      await _db.collection("ProductCategory").add(productCategory.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again. $e";
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _db.collection("Products").doc(product.id).update(product.toJson());
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again. $e";
    }
  }

  Future<void> updateProductSpecificValue(id, Map<String, dynamic> date) async {
    try {
      await _db.collection("Products").doc(id).update(date);
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again. $e";
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection("Products").get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again. $e";
    }
  }

  /// Get Limited Featured Products
  Future<List<ProductCategoryModel>> getProductCategories(String productId) async {
    try {
      final snapshot = await _db.collection("ProductCategory").where("productId", isEqualTo: productId).get();
      return snapshot.docs.map((querySnapshot) => ProductCategoryModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again. $e";
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      // Delete all data at once from firebase FireStore
      await _db.runTransaction((transaction) async {
        final productRef = _db.collection("Products").doc(product.id);
        final productSnap = await transaction.get(productRef);

        if(!productSnap.exists){
          throw Exception("Product not found");
        }

        // Fetch ProductCategories
        final productCategoriesSnapshot = await _db.collection("ProductCategory").where("productId", isEqualTo: product.id).get();
        final productCategories = productCategoriesSnapshot.docs.map((e) => ProductCategoryModel.fromSnapshot(e));

        if(productCategories.isNotEmpty){
          for(var productCategory in productCategories) {
            transaction.delete(_db.collection("ProductCategory").doc(productCategory.id));
          }
        }

        transaction.delete(productRef);
      });
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again. $e";
    }
  }

  Future<void> removeProductCategory(String productId, String categoryId) async {
    try {
      final result = await _db
          .collection("ProductCategory")
          .where("productId", isEqualTo: productId)
          .where("categoryId", isEqualTo: categoryId)
          .get();

      for (final doc in result.docs) {
        await doc.reference.delete();
      }

      print('Product category removed successfully.');
    } catch (e) {
      print('Failed to remove product category: $e');
      rethrow;
    }
  }
}

