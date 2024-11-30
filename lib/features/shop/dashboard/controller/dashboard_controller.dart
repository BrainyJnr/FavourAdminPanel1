import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/helpers/helper_function.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  // -- Order
  static final List<OrderModel> orders = [
    OrderModel(
        id: "she433",
        status: OrderStatus.processing,
        totalAmount: 245,
        orderDate: DateTime(2024, 5, 20),
        deliveryDate: DateTime(2024, 5, 20)),
    OrderModel(
        id: "uth433",
        status: OrderStatus.shipped,
        totalAmount: 245,
        orderDate: DateTime(2024, 11, 24),
        deliveryDate: DateTime(2024, 11, 24)),
    OrderModel(
        id: "yyy433",
        status: OrderStatus.delivered,
        totalAmount: 245,
        orderDate: DateTime(2024, 11, 25),
        deliveryDate: DateTime(2024, 11, 25)),
    OrderModel(
        id: "gcf433",
        status: OrderStatus.delivered,
        totalAmount: 200,
        orderDate: DateTime(2024, 11, 27),
        deliveryDate: DateTime(2024, 11, 27)),
    OrderModel(
        id: "cw2e03",
        status: OrderStatus.delivered,
        totalAmount: 245,
        orderDate: DateTime(2024, 11, 26),
        deliveryDate: DateTime(2024, 11, 26)),
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

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;

  // final AddressModel? address;
  final DateTime? deliveryDate;

  // final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = "",
    required this.status,
    // required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = "Paypal",
    // this.address,
    this.deliveryDate,
  });

  String get formattedOrderDate => fHelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? fHelperFunctions.getFormattedDate(deliveryDate!)
      : "";

  String get orderStatusText => status == OrderStatus.delivered
      ? "Delivered"
      : status == OrderStatus.shipped
          ? "Shipment on the way"
          : "Processing";

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userid": userId,
      "status": status.toString(),
      "totalAmount": totalAmount,
      "orderDate": orderDate,
      "paymentMethod": paymentMethod,
      // "address": address?.toJson(),
      "deliveryDate": deliveryDate,
      // "items": items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data["id"] as String,
      userId: data["userid"] as String,
      status:
          OrderStatus.values.firstWhere((e) => e.toString() == data["status"]),
      totalAmount: data["totalAmount"] as double,
      orderDate: (data["orderDate"] as Timestamp).toDate(),
      paymentMethod: data["paymentMethod"] as String,
      //address: AddressModel.fromMap(data["address"] as Map<String, dynamic>),
      //       deliveryDate: data["deliveryDate"] == null
      //           ? null
      //           : (data["deliveryDate"] as Timestamp).toDate(),
      //       items: (data["items"] as List<dynamic>)
      //           .map((itemData) =>
      //           CartItemModel.fromJson(itemData as Map<String, dynamic>))
      //           .toList(),
    );
  }
}
