import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:flutter/material.dart';

import '../row/category_rows.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return fPaginatedDataTable(
        columns: const [
          DataColumn2(label: Text("Category")),
          DataColumn2(label: Text("Parent Category")),
          DataColumn2(label: Text("Features")),
          DataColumn2(label: Text("Date")),
          DataColumn2(label: Text("Action"),fixedWidth: 100),
    ],
      source: CategoryRows(),);
  }
}
