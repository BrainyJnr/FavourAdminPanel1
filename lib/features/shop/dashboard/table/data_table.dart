import 'package:favour_adminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:favour_adminpanel/features/shop/dashboard/table/table_source.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return fPaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: fSizes.xl * 1.2,
      columns: const [
        DataColumn(label: Text("Order ID")),
        DataColumn(label: Text("Date")),
        DataColumn(label: Text("Items")),
        DataColumn(label: Text("Status")),
        DataColumn(label: Text("Amount")),
      ], source: OrderRows(),
    );  }
}
