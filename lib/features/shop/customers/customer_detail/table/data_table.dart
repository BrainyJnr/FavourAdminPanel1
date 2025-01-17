import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:favour_adminpanel/features/shop/customers/customer_detail/table/table_source.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:flutter/material.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return fPaginatedDataTable(
      minWidth: 550,
      tableHeight: 640,
      dataRowHeight: kMinInteractiveDimension,
      columns: [
      DataColumn2(label: Text("Order ID")),
      DataColumn2(label: Text("Date")),
      DataColumn2(label: Text("Items")),
      DataColumn2(label: Text("Status"),fixedWidth: fDeviceUtilis.isMobileScreen(context) ? 100 :null),
      DataColumn2(label: Text("Amount"),numeric: true),
    ],
    source: CustomerOrderRows(),);
  }
}
