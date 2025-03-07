import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:favour_adminpanel/features/shop/customers/all_customers/table/table_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/customer_controller.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Obx(
      () {
        Text(controller.filteredItems.length.toString());
        Text(controller.selectedRows.length.toString());

        // Table
      return  fPaginatedDataTable(
        minWidth: 700,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns:  [
        DataColumn2(label: Text("Customer"), onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
        DataColumn2(label: Text("Email")),
        DataColumn2(label: Text("Phone Number")),
        DataColumn2(label: Text("Registered")),
        DataColumn2(label: Text("Action"),fixedWidth: 100),
      ], source: CustomerRows(),

      ); }
        );
  }
}
