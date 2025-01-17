import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/features_authentication/models/user_model.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../routes/routes.dart';
import '../widgets/customer_info.dart';
import '../widgets/customer_orders.dart';
import '../widgets/customer_shipping_address.dart';

class CustomerDetailDesktopscreen extends StatelessWidget {
  const CustomerDetailDesktopscreen({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(fSizes.defaultSpace),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const fBreadCrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: "Godwin Chimdike Favour"
                    "",
                breadcrumbItems: [fRoutes.customers, "Details"]),
            const SizedBox(
              height: fSizes.spaceBtwSections,
            ),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Side Customer Information
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
