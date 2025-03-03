import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/helpers/helper_function.dart';
import 'package:get/get.dart';

import '../../orders/model/order_model.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  // -- Order
  static final List<OrderModel> orders = [
    OrderModel(
        id: "she433",taxCost: 0,shippingCost: 0,
        status: OrderStatus.processing,
        totalAmount: 245,
        orderDate: DateTime(2024, 5, 20),
        deliveryDate: DateTime(2024, 5, 20),
        items: [], userid: ''),
    OrderModel(
        id: "uth433",taxCost: 0,shippingCost: 0,
        status: OrderStatus.shipped,
        totalAmount: 245,
        orderDate: DateTime(2024, 11, 24),
        deliveryDate: DateTime(2024, 11, 24),
        items: [], userid: ''),
    OrderModel(
        id: "yyy433",taxCost: 0,shippingCost: 0,
        status: OrderStatus.delivered,
        totalAmount: 245,
        orderDate: DateTime(2024, 11, 25),
        deliveryDate: DateTime(2024, 11, 25),
        items: [], userid: ''),
    OrderModel(
        id: "gcf433",taxCost: 0,shippingCost: 0,
        status: OrderStatus.delivered,
        totalAmount: 200,
        orderDate: DateTime(2024, 11, 27),
        deliveryDate: DateTime(2024, 11, 27),
        items: [], userid: ''),
    OrderModel(
        id: "cw2e03",taxCost: 0,shippingCost: 0,
        status: OrderStatus.delivered,
        totalAmount: 245,
        orderDate: DateTime(2024, 11, 26),
        deliveryDate: DateTime(2024, 11, 26),
        items: [], userid: ''),
  ];

  @override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    super.onInit();
  }

  // Calculate weekly roles
  void _calculateWeeklySales() {
    // Initialize sales array for the week (7 days)
    weeklySales.value = List<double>.filled(7, 0.0);

    // Define the start of the week (last 7 days from today)
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));

    for (var order in orders) {
      // Check if the order is within the week range
      if (order.orderDate.isAfter(weekStart) &&
          order.orderDate.isBefore(weekStart.add(Duration(days: 7)))) {
        // Map weekday (1-7) to index (0-6)
        final index = (order.orderDate.weekday - 1) % 7;

        // Accumulate the total amount for the day
        weeklySales[index] += order.totalAmount;
      }
    }

    // Debug the result
    print('Weekly Sales: $weeklySales');
  }

  void _calculateOrderStatusData() {
    // Reset status data
    orderStatusData.clear();

    // Map to store total amounts for each status
    totalAmounts.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orders) {
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
}


