import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utilis/constants/enums.dart';
import '../../../../utilis/helpers/helper_function.dart';
import '../../address/address_model.dart';
import '../../cart/cart_item_model.dart';

class OrderModel {
  String id;
  final String userid;
  final String docId;
  OrderStatus status;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final bool billingAddressSameAsShipping;

  OrderModel({
    required this.items,
    required this.id,
    required this.userid, // ✅ Removed empty string default
    this.docId = "",
    required this.status,
    required this.totalAmount,
    required this.shippingCost,
    required this.taxCost,
    required this.orderDate,
    this.paymentMethod = "Cash On Delivery",
    this.billingAddress,
    this.shippingAddress,
    this.deliveryDate,
    this.billingAddressSameAsShipping = true,
  });

  String get formattedOrderDate => fHelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate =>
      deliveryDate != null ? fHelperFunctions.getFormattedDate(deliveryDate!) : "";

  String get orderStatusText =>
      status == OrderStatus.delivered
          ? "Delivered"
          : status == OrderStatus.shipped
          ? "Shipment on the way"
          : "Processing";

  static OrderModel empty() => OrderModel(
    items: [],
    id: "",
    userid: "", // ✅ Ensure it exists in empty model
    status: OrderStatus.pending,
    totalAmount: 0,
    shippingCost: 0,
    taxCost: 0,
    orderDate: DateTime.now(),
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userid": userid, // ✅ Fixed key (was "userid")
      "status": status.toString(),
      "totalAmount": totalAmount,
      "shippingAddress": shippingAddress?.toJson(),
      "shippingCost": shippingCost,
      "taxCost": taxCost,
      "billingAddress": billingAddress?.toJson(),
      "billingAddressSameAsShipping": billingAddressSameAsShipping,
      "items": items.map((item) => item.toJson()).toList(),
      "orderDate": orderDate,
      "paymentMethod": paymentMethod,
      "deliveryDate": deliveryDate,
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      docId: snapshot.id,
      id: data.containsKey("id") ? data["id"] as String : "",
      userid: data.containsKey("userid") ? data["userid"] as String : "", // ✅ Fixed field name
      status: data.containsKey("status")
          ? OrderStatus.values.firstWhere((e) => e.toString() == data["status"], orElse: () => OrderStatus.pending)
          : OrderStatus.pending,
      totalAmount: data.containsKey("totalAmount") ? (data["totalAmount"] as num).toDouble() : 0.0, // ✅ Fixed casting
      shippingCost: data.containsKey("shippingCost") ? (data["shippingCost"] as num).toDouble() : 0.0,
      taxCost: data.containsKey("taxCost") ? (data["taxCost"] as num).toDouble() : 0.0,
      orderDate: data.containsKey("orderDate") ? (data["orderDate"] as Timestamp).toDate() : DateTime.now(),
      paymentMethod: data.containsKey("paymentMethod") ? data["paymentMethod"] as String : "",
      billingAddress: data.containsKey("billingAddress")
          ? AddressModel.fromMap(data["billingAddress"] as Map<String, dynamic>)
          : AddressModel.empty(),
      shippingAddress: data.containsKey("shippingAddress")
          ? AddressModel.fromMap(data["shippingAddress"] as Map<String, dynamic>)
          : AddressModel.empty(),
      billingAddressSameAsShipping: data.containsKey("billingAddressSameAsShipping")
          ? data["billingAddressSameAsShipping"] as bool
          : true,
      deliveryDate: data.containsKey("deliveryDate") && data["deliveryDate"] != null
          ? (data["deliveryDate"] as Timestamp).toDate()
          : null,
      items: data.containsKey("items")
          ? (data["items"] as List<dynamic>)
          .map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>))
          .toList()
          : [],
    );
  }
}
