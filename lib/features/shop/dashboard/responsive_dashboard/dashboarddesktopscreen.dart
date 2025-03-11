import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/features/shop/dashboard/table/data_table.dart';
import 'package:favour_adminpanel/features/shop/dashboard/widget/weeklysales_widget.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utilis/constants/colors.dart';
import '../../products_c/controller/product_images_controller.dart';
import '../controller/dashboard_controller.dart';
import '../widget/fdashboard_card.dart';
import '../widget/orderstatus_piechart.dart';

class Dashboarddesktopscreen extends StatelessWidget {
  const Dashboarddesktopscreen({super.key});

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
                      // HEADING
                      Text(
                        "Dashboard",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(
                        height: fSizes.spaceBtwSections,
                      ),

                      //Cards
                      Row(
                        children: [
                          Expanded(
                              child: Obx(
                            () => fDashboardCard(
                              headingIcon: Iconsax.note,
                              headingIconBgColor: Colors.blue.withOpacity(0.1),
                              headingIconColor: Colors.blue,
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
                              child: Obx(
                            () => fDashboardCard(
                                headingIcon: Iconsax.external_drive,
                                headingIconBgColor: Colors.green.withOpacity(0.1),
                                headingIconColor: Colors.green,
                                stats: 15,
                                title: "Average Order Value",
                                subTitle:
                                    '\$${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2)}'),
                          )),
                          SizedBox(
                            width: fSizes.spaceBtwItems,
                          ),
                          Expanded(
                              child: Obx(
                            () => fDashboardCard(
                              headingIcon: Iconsax.box,
                              headingIconBgColor: Colors.deepPurple.withOpacity(0.1),
                              headingIconColor:
                                  Colors.deepPurple,
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
                              headingIconBgColor: Colors.deepOrange.withOpacity(0.1),
                              headingIconColor:
                                  Colors.deepOrange,
                              stats: 2,
                              title: "Visitors",
                              subTitle: controller.customerController.allItems.length.toString(),
                            ),
                          )),
                        ],
                      ),

                      SizedBox(
                        height: fSizes.spaceBtwSections,
                      ),
                      //GRAPHS
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                //BAR GRAPH
                                fWeeklySalesGraph(),
                                SizedBox(
                                  height: fSizes.spaceBtwSections,
                                ),

                                //ORDERS
                                fRoundedContainer(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Recent Orders",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      const SizedBox(
                                        height: fSizes.spaceBtwSections,
                                      ),
                                      const DashboardOrderTable()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),

                          //PIE CHART
                          Expanded(child: OrderstatusPiechart()),

                          fRoundedContainer(),
                        ],
                      )
                    ]))));
  }
}
