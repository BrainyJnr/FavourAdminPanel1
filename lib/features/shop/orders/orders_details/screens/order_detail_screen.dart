import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/shop/orders/orders_details/responsive_orderdetails_screens/order_detail_desktop.dart';
import 'package:favour_adminpanel/features/shop/orders/orders_details/responsive_orderdetails_screens/order_detail_mobile.dart';
import 'package:favour_adminpanel/features/shop/orders/orders_details/responsive_orderdetails_screens/order_detail_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    final orderId = Get.parameters['orderId'];
    return fSiteTemplate(desktop: OrderDetailDesktop(order: order),tablet: OrderDetailTablet(order: order),mobile: OrderDetailMobile(order: order),);
  }
}
