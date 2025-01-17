import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:favour_adminpanel/features/shop/orders/all_orders/table/table_Source.dart';
import 'package:flutter/material.dart';

import '../../../../../utilis/device/device_utility.dart';

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return fPaginatedDataTable(
      minWidth: 700,
      columns: [
        const DataColumn2(label: Text("Order ID")),
        const DataColumn2(label: Text("Date")),
        const DataColumn2(label: Text("Items")),
        DataColumn2(label: Text("Status"),fixedWidth: fDeviceUtilis.isMobileScreen(context) ? 120 : null ),
        const DataColumn2(label: Text("Amount")),
        const DataColumn2(label: Text("Action"),fixedWidth: 100),
      ],
      source: OrderRow(),
    );
  }
}
