import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/data/repositories/user/user_repository.dart';
import 'package:favour_adminpanel/features/shop/address/address_model.dart';
import 'package:favour_adminpanel/features/shop/orders/model/order_model.dart';
import 'package:favour_adminpanel/features_authentication/models/user_model.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  static OrderDetailController get instance => Get.find();

  RxBool loading = true.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<AddressModel> address = AddressModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  /// -- Load while loading categories
  Future<void> getCustomerOfCurrentOrder() async {
    try {
      loading.value = true;

      // Debugging - Print userId before making the request
      print("Fetching user details for userId: ${order.value.userid}");

      if (order.value.userid == null || order.value.userid!.trim().isEmpty) {
        throw Exception("Invalid userId: It is either null or empty.");
      }

      // Fetch customer details
      final user = await UserRepository.instance.fetchUserDetails(order.value.userid);

      customer.value = user;
    } catch (e, stackTrace) {
      print("Error in getCustomerOfCurrentOrder: $e");
      print("Stack Trace: $stackTrace");

      fLoaders.errorSnackBar(title: "Oh Snap! Error", message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}