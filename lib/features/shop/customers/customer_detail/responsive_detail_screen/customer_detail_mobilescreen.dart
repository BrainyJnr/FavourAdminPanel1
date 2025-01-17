import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../features_authentication/models/user_model.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../widgets/customer_info.dart';
import '../widgets/customer_orders.dart';
import '../widgets/customer_shipping_address.dart';

class CustomerDetailMobilescreen extends StatelessWidget {
  const CustomerDetailMobilescreen({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(fSizes.defaultSpace),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const fBreadCrumbsWithHeading(
                          returnToPreviousScreen: true,
                          heading: "Godwin Chimdike Favour"
                              "",
                          breadcrumbItems: [fRoutes.customers, "Details"]),
                      const SizedBox(
                        height: fSizes.spaceBtwSections,
                      ),

                      // Customer Info
                      CustomerInfo(customer: customer),
                      SizedBox(
                        height: fSizes.spaceBtwSections,
                      ),

                      // Shipping Address
                      ShippingAddress(),
                      SizedBox(
                        height: fSizes.spaceBtwSections,
                      ),

                      // left Side Customer Orders
                      CustomerOrders(),
                    ]))));
  }
}
