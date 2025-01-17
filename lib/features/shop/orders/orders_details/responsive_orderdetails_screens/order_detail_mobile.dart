import 'package:flutter/material.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../../dashboard/controller/dashboard_controller.dart';
import '../widgets/customer_info.dart';
import '../widgets/order_info.dart';
import '../widgets/order_items.dart';
import '../widgets/order_transaction.dart';

class OrderDetailMobile extends StatelessWidget {
  const OrderDetailMobile ({super.key, required this.order});

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
