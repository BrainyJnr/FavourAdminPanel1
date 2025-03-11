import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/features/shop/dashboard/controller/dashboard_controller.dart';
import 'package:favour_adminpanel/features/shop/orders/controller/order_controller.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderRows extends DataTableSource {
  final controller = OrderController.instance;
  @override
  DataRow? getRow(int index) {
    final order = controller.filteredItems[index];
    return DataRow2(
        onTap: () => Get.toNamed(fRoutes.ordersDetails, arguments: order),
        selected: controller.selectedRows[index],
        onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
        cells: [
          DataCell(
              Text(order.id,style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: fColors.primary),)
          ),
          DataCell(Text(order.formattedOrderDate)),
          DataCell(Text('${order.items.length} Items')),
          DataCell(fRoundedContainer(
            radius: fSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(vertical: fSizes.xs,horizontal: fSizes.md),
            backgroundColor: fHelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
            child: Text(order.status.name.capitalize.toString(),
              style: TextStyle(color: fHelperFunctions.getOrderStatusColor(order.status)),),
          )),

          DataCell(Text('\$${order.totalAmount}'))

        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;

}
