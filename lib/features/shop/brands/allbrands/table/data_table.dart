import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'brand_row.dart';

class BrandTable extends StatelessWidget {
  const BrandTable({super.key});

  @override
  Widget build(BuildContext context) {
    return fPaginatedDataTable(
      minWidth: 708,
      tableHeight: 760,
      dataRowHeight: 64,
      columns: [
        DataColumn2(
            label: Text("Brand"),
            fixedWidth:
                fDeviceUtilis.isMobileScreen(Get.context!) ? null : 280),
        const DataColumn2(label: Text("Brands")),
        DataColumn2(
            label: Text("Featured"),
            fixedWidth:
                fDeviceUtilis.isMobileScreen(Get.context!) ? null : 108),
        DataColumn2(
            label: Text("Date"),
            fixedWidth:
                fDeviceUtilis.isMobileScreen(Get.context!) ? null : 200),
        DataColumn2(
            label: Text("Action"),
            fixedWidth:
                fDeviceUtilis.isMobileScreen(Get.context!) ? null : 100),
      ],
      source: BrandsRows(),
    );
  }
}
