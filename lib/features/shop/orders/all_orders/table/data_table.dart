import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:favour_adminpanel/features/shop/orders/all_orders/table/table_Source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import '../../../../../utilis/device/device_utility.dart';
import '../../controller/order_controller.dart';

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Obx(
      () {
        final order = controller.filteredItems.toString();
        print("Order Row Data: ${order.length}");
        Text(controller.selectedRows.length.toString());
     return   fPaginatedDataTable(
          minWidth: 700,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            const DataColumn2(label: Text("Order ID")),
            DataColumn2(label: Text("Date"),onSort: (columnIndex, ascending) => controller.sortByData(columnIndex, ascending)),
            const DataColumn2(label: Text("Items")),
            DataColumn2(label: Text("Status"),fixedWidth: fDeviceUtilis.isMobileScreen(context) ? 120 : null ),
            const DataColumn2(label: Text("Amount")),
            const DataColumn2(label: Text("Action"),fixedWidth: 100),
          ],
          source: OrderRow(),
        );
      },
    );
  }
}
