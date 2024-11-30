import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/custom_shapes/container/fcircular_container.dart';
import 'package:favour_adminpanel/features/shop/dashboard/controller/dashboard_controller.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/helpers/helper_function.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utilis/constants/enums.dart';

class OrderstatusPiechart extends StatelessWidget {
  const OrderstatusPiechart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return fRoundedContainer(
      child: SingleChildScrollView( // Allow scrolling if content overflows
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left: 10),
              child: Text(
                "Order Status",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(
              height: fSizes.spaceBtwSections,
            ),

            // Graph
            SizedBox(
              height: 400, // Ensure this height is appropriate for your graph
              child: Padding(padding: EdgeInsets.all(20),
                child: PieChart(
                  PieChartData(
                    sections: controller.orderStatusData.entries.map((entry) {
                      final status = entry.key;
                      final count = entry.value;

                      return PieChartSectionData(
                        radius: 100,
                        title: count.toString(),
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
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                      enabled: true,
                    ),
                  ),
                ),
              ),
            ),


            // Show Status and Color Meta
               SizedBox(
                 width: double.infinity,
                 child: DataTable(
                  columns: [
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Orders")),
                    DataColumn(label: Text("Total")),
                  ],
                  rows: controller.orderStatusData.entries.map((entry) {
                    final OrderStatus status = entry.key;
                    final int count = entry.value;
                    final totalAmount = controller.totalAmounts[status] ?? 0;

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
                                  ' ${controller.getDisplayStatusName(status)}',
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
            ]),

        ),

    );

  }
}
