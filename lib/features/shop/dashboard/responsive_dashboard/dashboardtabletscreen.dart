import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/styles/frounded_container.dart';
import '../controller/dashboard_controller.dart';
import '../table/data_table.dart';
import '../widget/fdashboard_card.dart';
import '../widget/orderstatus_piechart.dart';
import '../widget/weeklysales_widget.dart';

class Dashboardtabletscreen extends StatelessWidget {
  const Dashboardtabletscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //HEADING
                Text(
                  "Dashboard",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: fSizes.spaceBtwSections,
                ),

                //CARDS
                Row(
                  children: [
                    Expanded(
                        child: Obx(
                      () => fDashboardCard(
                        headingIcon: Iconsax.note,
                        headingIconBgColor: Colors.blue,
                        headingIconColor: Colors.blue.withOpacity(0.1),
                        stats: 25,
                        title: "Sales total",
                        subTitle:
                            '\$${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',
                      ),
                    )),
                    SizedBox(
                      width: fSizes.spaceBtwItems,
                    ),
                    Expanded(
                      child: fDashboardCard(
                          headingIcon: Iconsax.external_drive,
                          headingIconBgColor: Colors.green,
                          headingIconColor: Colors.green.withOpacity(0.1),
                          stats: 15,
                          title: "Average Order Value",
                          subTitle:
                              '\$${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2)}'),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Obx(
                      () => fDashboardCard(
                        headingIcon: Iconsax.box,
                        headingIconBgColor: Colors.deepPurple,
                        headingIconColor: Colors.deepPurple.withOpacity(0.1),
                        stats: 44,
                        title: "Total Orders",
                        subTitle:
                            '\$${controller.orderController.allItems.length}',
                      ),
                    )),
                    SizedBox(
                      width: fSizes.spaceBtwItems,
                    ),
                    Expanded(
                        child: Obx(
                      () => fDashboardCard(
                        headingIcon: Iconsax.user,
                        headingIconBgColor: Colors.deepOrange,
                        headingIconColor: Colors.deepOrange.withOpacity(0.1),
                        stats: 25,
                        title: "Visitors",
                        subTitle: controller.customerController.allItems.length
                            .toString(),
                      ),
                    )),
                    SizedBox(
                      width: fSizes.spaceBtwItems,
                    ),
                  ],
                ),
                //BAR GRAPH
                fWeeklySalesGraph(),
                SizedBox(
                  height: fSizes.spaceBtwSections,
                ),

                //ORDERS
                fRoundedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recent Orders",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: fSizes.spaceBtwSections,
                      ),
                      const DashboardOrderTable()
                    ],
                  ),
                ),

                SizedBox(
                  height: fSizes.spaceBtwSections,
                ),

                //PIE CHART
                OrderstatusPiechart(),
              ],
            )),
      ),
    );
  }
}
