import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:favour_adminpanel/features/shop/products/all_products/table/table_source.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/product_controller.dart';

class ProductTable extends StatelessWidget {
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Obx(() {
      // Products & selected Rows are hidden => Just to update the UI => Obx => [ProductRows]
          Text(controller.filteredItems.length.toString());
          Text(controller.selectedRows.length.toString());
      return fPaginatedDataTable(
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          minWidth: 1800,
          columns: [
            DataColumn2(
              label: Text("Products"),
              fixedWidth: fDeviceUtilis.isDesktopScreen(context) ? 300 : 400,
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending),
            ),
            DataColumn2(
              label: Text("Stock"),
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending),
            ),
            DataColumn2(
              label: Text("Sold"),
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending),
            ),
            DataColumn2(
              label: Text("Brand"),
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending),
            ),
            DataColumn2(
              label: Text("Price"),
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending),
            ),
            DataColumn2(
              label: Text("Date"),
            ),
            DataColumn2(label: Text("Action"),
      fixedWidth: 100),
          ],
          source: ProductsRows());
    });
  }
}
