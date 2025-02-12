import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:favour_adminpanel/features/shop/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../row/category_rows.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());
      return fPaginatedDataTable(
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        minWidth: 700,
        columns: [
          DataColumn2(
              label: const Text("Category"),
              onSort: (columnIndex, ascending) => controller.sortByName(
                    columnIndex,
                    ascending,
                  )),
          DataColumn2(
              label: Text("Parent Category"),
              onSort: (columnIndex, ascending) => controller.sortByName(
                    columnIndex,
                    ascending,
                  )),
          const DataColumn2(label: Text("Features")),
          const DataColumn2(label: Text("Date")),
          const DataColumn2(label: Text("Action"), fixedWidth: 100),
        ],
        source: CategoryRows(),
      );
    });
  }
}
