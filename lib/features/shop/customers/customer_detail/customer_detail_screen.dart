import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/shop/customers/all_customers/responsive_screens/customer_mobile_screen.dart';
import 'package:favour_adminpanel/features/shop/customers/customer_detail/responsive_detail_screen/customer_detail_desktopscreen.dart';
import 'package:favour_adminpanel/features/shop/customers/customer_detail/responsive_detail_screen/customer_detail_mobilescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = Get.arguments;
    final customerId = Get.parameters["customerId"];
    return fSiteTemplate(desktop: CustomerDetailDesktopscreen(customer: customer),mobile: CustomerDetailMobilescreen(customer: customer),);
  }
}
