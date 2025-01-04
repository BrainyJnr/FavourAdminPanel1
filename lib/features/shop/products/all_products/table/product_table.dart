import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:favour_adminpanel/features/shop/products/all_products/table/table_source.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:flutter/material.dart';

class ProductTable extends StatelessWidget {
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    return fPaginatedDataTable(
        minWidth: 1800,
        columns: [
          DataColumn2(label: Text("Products"),
          fixedWidth: fDeviceUtilis.isDesktopScreen(context) ? 300 : 400),
          const DataColumn2(label: Text("Stock")),
          const DataColumn2(label: Text("Brand")),
          const DataColumn2(label: Text("Price")),
          const DataColumn2(label: Text("Date")),
          const DataColumn2(label: Text("Action"),fixedWidth: 100),


        ],
        source: ProductsRows());
  }
}
