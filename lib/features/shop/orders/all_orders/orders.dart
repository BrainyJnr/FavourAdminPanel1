import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/shop/orders/all_orders/responsive_screen/order_desktop_screen.dart';
import 'package:favour_adminpanel/features/shop/orders/all_orders/responsive_screen/order_mobile_screen.dart';
import 'package:favour_adminpanel/features/shop/orders/all_orders/responsive_screen/order_tablet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/order_model.dart';
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as OrderModel? ?? OrderModel.empty();
    final orderId = Get.parameters['orderId'];
    return fSiteTemplate(desktop: OrderDesktopScreen(order: order),tablet: OrderTabletScreen(order: order),mobile: OrderMobileScreen(order: order),);
  }
}
