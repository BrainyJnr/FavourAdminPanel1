import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/features/shop/customers/customer_detail/controller/customer_detail_controller.dart';
import 'package:favour_adminpanel/features_authentication/models/user_model.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../routes/routes.dart';
import '../widgets/customer_info.dart';
import '../widgets/customer_orders.dart';
import '../widgets/customer_shipping_address.dart';

class CustomerDetailDesktopscreen extends StatelessWidget {
  const CustomerDetailDesktopscreen({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController());
    controller.customer.value = customer;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(fSizes.defaultSpace),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
             fBreadCrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: customer.fullName,
                breadcrumbItems: [fRoutes.customers, "Details"]),
            const SizedBox(
              height: fSizes.spaceBtwSections,
            ),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Right Side Customer Information
                Expanded(
                    child: Column(
                  children: [
                    // Customer Info
                    CustomerInfo(customer: customer),
                    SizedBox(
                      height: fSizes.spaceBtwSections,
                    ),

                    // Shipping Address
                    ShippingAddress()
                  ],
                )),

                const SizedBox(
                  width: fSizes.spaceBtwSections,
                ),

                // Right Side Customer Orders
                const Expanded(
                  flex: 2,
                  child: CustomerOrders(),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
