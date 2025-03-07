import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/data/repositories/user/user_repository.dart';
import 'package:favour_adminpanel/features/shop/address/repository/address_repository.dart';
import 'package:favour_adminpanel/features/shop/orders/model/order_model.dart';
import 'package:favour_adminpanel/features/shop/orders/repositroy/order_repository.dart';
import 'package:favour_adminpanel/features_authentication/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerDetailController extends GetxController {
  static CustomerDetailController get instance => Get.find();

  RxBool ordersLoading = true.obs;
  RxBool addressLoading = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<bool> selectRows = <bool>[].obs;
  Rx<UserModel> customer = UserModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());
  final searchTextController = TextEditingController();
  RxList<OrderModel> allCustomerOrders = <OrderModel>[].obs;
  RxList<OrderModel> filteredCustomerOrders = <OrderModel>[].obs;

  /// --- Load Customer Orders
  Future<void> getCustomerOrders() async {
    try {
      ordersLoading.value = true;

      if(customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.orders = await UserRepository.instance.fetchUserOrders(customer.value.id!);
      }

      // Update the categories list
      allCustomerOrders.assignAll(customer.value.orders ?? []);

      // Filter featured categories
      filteredCustomerOrders.assignAll(customer.value.orders ?? []);

      selectRows.assignAll(List.generate(customer.value.orders != null? customer.value.orders!.length : 0, (index) => false));
    } catch (e) {
      fLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      ordersLoading.value = false;
    }
  }

  /// -- Load customer orders
  Future<void> getCustomerAddresses() async {
    try {
      addressLoading.value = true;

      if(customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.addresses = await addressRepository.fetchUserAddresses(customer.value.id!);
      }
    } catch (e) {
      fLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      addressLoading.value = false;
    }
  }

  /// -- Search Query Filter
 void searchQuery(String query) {
    filteredCustomerOrders.assignAll(
      allCustomerOrders.where((customer) =>
      customer.id.toLowerCase().contains(query.toLowerCase()) || customer.orderDate.toString().contains(query.toLowerCase()))
    );

    // Notify listeners about the change
   update();
 }

 /// -- Sorting related code
 void sortById(int sortColumnIndex, bool ascending) {
    sortAscending.value = ascending;
    filteredCustomerOrders.sort((a, b) {
      if (ascending) {
        return a.id.toLowerCase().compareTo(b.id.toLowerCase());
      } else {
        return b.id.toLowerCase().compareTo(a.id.toLowerCase());
      }
    });
    this.sortColumnIndex.value = sortColumnIndex;

    update();
 }
}