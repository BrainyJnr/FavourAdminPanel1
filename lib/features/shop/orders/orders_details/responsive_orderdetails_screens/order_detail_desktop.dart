import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/features/shop/orders/orders_details/widgets/customer_info.dart';
import 'package:favour_adminpanel/features/shop/orders/orders_details/widgets/order_items.dart';
import 'package:favour_adminpanel/features/shop/orders/orders_details/widgets/order_transaction.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../model/order_model.dart';
import '../widgets/order_info.dart';

class OrderDetailDesktop extends StatelessWidget {
  const OrderDetailDesktop({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              fBreadCrumbsWithHeading(
                  heading: order.id,
                  returnToPreviousScreen: true,
                  breadcrumbItems: const [fRoutes.orders, 'Details']),
              const SizedBox(
                height: fSizes.spaceBtwSections,
              ),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side Order Information
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // Order Info
                          OrderInfo(order: order),
                          SizedBox(
                            height: fSizes.spaceBtwSections,
                          ),

                          // Items
                          OrderItems(order: order),
                          SizedBox(
                            height: fSizes.spaceBtwSections,
                          ),

                          // Transaction
                          OrderTransaction(order: order)
                        ],
                      )),
                  SizedBox(
                    height: fSizes.spaceBtwSections,
                  ),

                  Expanded(
                      child: Column(
                    children: [
                      // Customer Info
                      CustomerInfoOrder(order: order),
                      SizedBox(
                        height: fSizes.spaceBtwSections,
                      ),
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
