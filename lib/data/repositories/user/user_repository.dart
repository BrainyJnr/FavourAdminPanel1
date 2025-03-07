import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favour_adminpanel/data/repositories/authentication.dart';
import 'package:favour_adminpanel/features/shop/orders/model/order_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../features_authentication/models/user_model.dart';
import '../../../utilis/exceptors/firebase_exceptors.dart';
import '../../../utilis/exceptors/format_exception.dart';
import '../../../utilis/exceptors/platform_exception.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  ///Function to save user data to Firestore.
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    }on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    }on FormatException catch(_) {
      throw const fFormatException();
    }on PlatformException catch(e) {
      throw fPlatformException(e.code).message;
    }catch (e){
      throw "Something went wrong. Please try again";
    }
  }

  ///Function to fetch user details based on user ID.
  Future<UserModel> fetchAdminDetails() async {
    try {
      final docSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser!.uid).get();
      return UserModel.fromSnapshot(docSnapshot);
    }on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    }on FormatException catch(_) {
      throw const fFormatException();
    }on PlatformException catch(e) {
      throw fPlatformException(e.code).message;
    }catch (e){
      throw "Something went wrong. $e";
    }
  }

  Future<UserModel> fetchUserDetails(String id) async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(id).get();

      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        throw "User not found";
      }
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. $e";
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final querySnapshot = await _db.collection("Users").orderBy("FirstName").get();
      return querySnapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();

    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. $e";
    }
  }

  Future<List<OrderModel>> fetchUserOrders(String userId) async {
    try {
      final documentSnapshot = await _db.collection("Orders").where("userid", isEqualTo: userId).get();
      return documentSnapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. $e";
    }
    }

    Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db.collection("Users").doc(updateUser.id).update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. $e";
    }
  }

  /// Update any field is specific users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Users").doc(AuthenticationRepository.instance.authUser!.uid).update(json);
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. $e";
    }
  }

  /// Delete User Data
  Future<void> deleteUser(String id) async {
    try {
      await _db.collection("Users").doc(id).delete();
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. $e";
    }
    }
  }

