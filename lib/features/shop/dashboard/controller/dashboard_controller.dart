import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favour_adminpanel/data/abstract/base_data_table_controller.dart';
import 'package:favour_adminpanel/features/shop/customers/controller/customer_controller.dart';
import 'package:favour_adminpanel/features/shop/orders/controller/order_controller.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/helpers/helper_function.dart';
import 'package:get/get.dart';

import '../../orders/model/order_model.dart';

class DashboardController extends fBaseController<OrderModel> {
  static DashboardController get instance => Get.find();

  final orderController = Get.put(OrderController());
  final customerController = Get.put(CustomerController());

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  // -- Order


  // Calculate weekly roles
  void _calculateWeeklySales() {
    // Initialize sales array for the week (7 days)
    weeklySales.value = List<double>.filled(7, 0.0);

    // Define the start of the week (last 7 days from today)
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));

    for (var order in orderController.allItems) {
      // Check if the order is within the week range
      final DateTime orderWeekStart = fHelperFunctions.getStartOfWeek(
          order.orderDate);

      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;

        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;
      }
    }
  }

  void _calculateOrderStatusData() {
    // Reset status data
    orderStatusData.clear();

    // Map to store total amounts for each status
    totalAmounts.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orderController.allItems) {
      // count orders
      final status = order.status;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;

      // calculate total amounts for each status
      totalAmounts[status] = (totalAmounts[status] ?? 0) + order.totalAmount;
    }
  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return "Pending";

      case OrderStatus.processing:
        return "Processing";

      case OrderStatus.shipped:
        return "Shipped";

      case OrderStatus.delivered:
        return "Delivered";
      case OrderStatus.cancelled:
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) => false;

  @override
  Future<void> deleteItem(OrderModel item) async {
  }

  @override
  Future<List<OrderModel>> fetchItems() async {
    // Fetch Orders if empty
    if(orderController.allItems.isEmpty) {
      await orderController.fetchItems();
    }

    // Fetch Customers if empty
    if(customerController.allItems.isEmpty) {
      await customerController.fetchItems();
    }

    // Calculate weekly sales
    _calculateWeeklySales();

    // Calculate Order Status counts
    _calculateOrderStatusData();

    return orderController.allItems;
  }
}


