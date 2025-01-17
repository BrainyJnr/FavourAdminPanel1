import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/data_table/ftable_action_table.dart';
import 'package:favour_adminpanel/features/shop/dashboard/controller/dashboard_controller.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderRow extends DataTableSource {

  @override
  DataRow? getRow(int index) {
    final order = DashboardController.orders[index];
    return DataRow2(
        onTap: () => Get.toNamed(fRoutes.ordersDetails, arguments: order),
        selected: false,
        onSelectChanged: (value) {},
        cells: [
          DataCell(Text(order.id, style: Theme
              .of(Get.context!)
              .textTheme
              .bodyMedium!
              .apply(color: fColors.primary),)),
          DataCell(Text(order.formattedOrderDate)),
          DataCell(Text('${order.items.length}Items')),
          DataCell(
            fRoundedContainer(
              radius: fSizes.cardRadiusSm,
              padding: EdgeInsets.symmetric(vertical: fSizes.sm,horizontal: fSizes.md),
              backgroundColor: fHelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
              child: Text(
                order.status.name.capitalize.toString(),
                style: TextStyle(color: fHelperFunctions.getOrderStatusColor(order.status)),
              ),
            )
          ),

          DataCell(Text('\$${order.totalAmount}')),
          DataCell(
            fTableActionButton(
              view: true,
              edit: false,
              onViewPressed: () => Get.toNamed(fRoutes.ordersDetails,arguments: order,parameters: {'orderId': order.id}) ,
              onDeletePressed: () {},
            )
          )

        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;
}