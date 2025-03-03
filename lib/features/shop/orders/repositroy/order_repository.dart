import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../utilis/exceptors/firebase_auth_exceptors.dart';
import '../../../../utilis/exceptors/firebase_exceptors.dart';
import '../../../../utilis/exceptors/format_exception.dart';
import '../../../../utilis/exceptors/platform_exception.dart';
import '../model/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /* -------------------------- FUNCTIONS------------------------*/

  /// Get  all order related to current User
  Future<List<OrderModel>>  getAllOrders() async {
    try {
      //final userId = AuthenticationRepository.instance.authUser.uid;
     // if (userId.isEmpty) throw "Unable to find user information. Try again in few minutes.";

      final result = await _db.collection("Orders").orderBy("orderDate", descending: true).get();
      return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw "Something went wrong while fetching Order Information. $e ";
    }
  }

  Future<void> order(OrderModel order,) async {
    try {
      await _db.collection("Orders").add(order.toJson());
    } catch (e) {
      throw "Something went wrong while saving Order Information. Try again later.";
    }
  }

  Future<void> updateOrderSpecificValue(String orderId, Map<String, dynamic> data) async {
    try {
      await _db.collection("Orders").doc(orderId).update(data);
    } catch (e) {
      throw "Something went wrong while saving Order Information. Try again later.";
    }
  }


  Future<void> deleteOrder(String orderId) async {
    try {
      await _db.collection("Orders").doc(orderId).delete();
    } on FirebaseAuthException catch (e) {
      throw fFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

}
