import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/features/shop/dashboard/table/data_table.dart';
import 'package:favour_adminpanel/features/shop/dashboard/widget/weeklysales_widget.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../utilis/constants/colors.dart';
import '../../products_c/controller/product_images_controller.dart';
import '../widget/fdashboard_card.dart';
import '../widget/orderstatus_piechart.dart';

class Dashboarddesktopscreen extends StatelessWidget {
  const Dashboarddesktopscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());
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
                      OutlinedButton(
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(color: Colors.white),
                              backgroundColor: fColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () => controller.selectThumbnailImage(),
                          child: Text("Select Single Image",style: TextStyle(color: Colors.white),)),
                      const SizedBox(
                        height: fSizes.spaceBtwSections,
                      ),
                      OutlinedButton(
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(color: Colors.white),
                              backgroundColor: fColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () =>
                              controller.selectMultipleProductImages(),
                          child: Text("Select Multiple Single Image",style: TextStyle(color: Colors.white))),
                      const SizedBox(
                        height: fSizes.spaceBtwSections,
                      ),

                      //Cards
                      Row(
                        children: [
                          Expanded(
                              child: fDashboardCard(
                                stats: 25,
                                title: "Sales total",
                                subTitle: '\$356',
                              )),
                          SizedBox(
                            width: fSizes.spaceBtwItems,
                          ),
                          Expanded(
                              child: fDashboardCard(
                                stats: 25,
                                title: "Sales total",
                                subTitle: '\$356',
                              )),
                          SizedBox(
                            width: fSizes.spaceBtwItems,
                          ),
                          Expanded(
                              child: fDashboardCard(
                                stats: 25,
                                title: "Sales total",
                                subTitle: '\$356',
                              )),
                          SizedBox(
                            width: fSizes.spaceBtwItems,
                          ),
                          Expanded(
                              child: fDashboardCard(
                                stats: 25,
                                title: "Sales total",
                                subTitle: '\$356',
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
