import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/custom_shapes/container/fcircular_container.dart';
import 'package:favour_adminpanel/common/widgets/loaders/fanimation.dart';
import 'package:favour_adminpanel/features/shop/dashboard/controller/dashboard_controller.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:favour_adminpanel/utilis/helpers/helper_function.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/icons/fcircular_icon.dart';
import '../../../../utilis/constants/enums.dart';

class OrderstatusPiechart extends StatelessWidget {
  const OrderstatusPiechart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return fRoundedContainer(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        fCircularIcon(
          icon: Iconsax.status,
          backgroungColor: Colors.amber.withOpacity(0.1),
          color: Colors.amber,
          size: fSizes.md,
        ),
        const SizedBox(
          width: fSizes.spaceBtwItems,
        ),
        Text(
          "Orders Status",
          style: Theme.of(context).textTheme.headlineSmall,
        )
      ]),
      const SizedBox(
        height: fSizes.spaceBtwSections,
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Obx(() => controller.orderStatusData.isNotEmpty
            ?
            // Graph
            SizedBox(
                height: 400,
                // Ensure this height is appropriate for your graph
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius:
                          fDeviceUtilis.isTabletScreen(context) ? 80 : 50,
                      startDegreeOffset: 180,
                      sections: controller.orderStatusData.entries.map((entry) {
                        final status = entry.key;
                        final count = entry.value;

                        return PieChartSectionData(
                          radius: 100,
                          showTitle: true,
                          title: "$count",
                          value: count.toDouble(),
                          color: fHelperFunctions.getOrderStatusColor(status),
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                      pieTouchData: PieTouchData(
                        touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {},
                        enabled: true,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(
                height: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [fLoaderAnimation()],
                ),
              )),

        // Show Status and Color Meta
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => DataTable(
              columns: [
                DataColumn(label: Text("Status")),
                DataColumn(label: Text("Orders")),
                DataColumn(label: Text("Total")),
              ],
              rows: controller.orderStatusData.entries.map((entry) {
                final OrderStatus status = entry.key;
                final int count = entry.value;
                final double totalAmount = controller.totalAmounts[status]!;
                final String displayStatus =
                    controller.getDisplayStatusName(status);

                return DataRow(
                  cells: [
                    DataCell(
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          fCircular_Container(
                            width: 20,
                            height: 20,
                            backgroundColor:
                                fHelperFunctions.getOrderStatusColor(status),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              ' $displayStatus',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Text(
                        count.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataCell(
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        )
      ])
    ]));
  }
}
