import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:favour_adminpanel/features/shop/dashboard/table/table_source.dart';
import 'package:favour_adminpanel/features/shop/orders/controller/order_controller.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    return Obx(
      () {
        Text(controller.filteredItems.length.toString());
        Text(controller.selectedRows.length.toString());
        // Table
        return fPaginatedDataTable(
          minWidth: 700,
          tableHeight: 500,
          dataRowHeight: fSizes.xl * 1.2,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(
                label: Text("Order ID"),
                onSort: (columnIndex, ascending) =>
                    controller.sortById(columnIndex, ascending)),
            const DataColumn2(label: Text("Date")),
            const DataColumn2(label: Text("Items")),
            DataColumn2(
                label: Text("Status"),
                fixedWidth: fDeviceUtilis.isMobileScreen(context) ? 120 : null),
            const DataColumn(label: Text("Amount")),
          ],
          source: OrderRows(),
        );
      },
    );
  }
}
