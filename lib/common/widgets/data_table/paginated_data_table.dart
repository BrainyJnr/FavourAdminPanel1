import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/widgets/loaders/fAnimationLoaderWidget.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class fPaginatedDataTable extends StatelessWidget {
  const fPaginatedDataTable({
    super.key,
    this.sortAscending = true,
    this.sortColumnIndex,
    this.rowsPerPage = 10,
    required this.source,
    required this.columns,
    this.onPageChanged,
    this.dataRowHeight = fSizes.xl * 2,
    this.minWidth = 1000,
    this.tableHeight = 760,
  });

  final bool sortAscending;

  final int? sortColumnIndex;

  final int rowsPerPage;

  final DataTableSource source;

  final List<DataColumn> columns;

  final Function(int)? onPageChanged;

  final double dataRowHeight;

  final double tableHeight;

  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Set the dynamic height of the PaginatedDataTable
      height: tableHeight,
      child: Theme(
          data: Theme.of(context).copyWith(
              cardTheme: const CardTheme(color: Colors.white, elevation: 0)),
          child: PaginatedDataTable2(
            columnSpacing: 12,
            source: source,
            columns: columns,
            dividerThickness: 0,
            rowsPerPage: rowsPerPage,
            horizontalMargin: 12,
            // tableHeight: tableHeight,
            minWidth: minWidth,
            dataRowHeight: dataRowHeight,

            // CheckBox
            showCheckboxColumn: true,

            // Pagination
            onPageChanged: onPageChanged,
            showFirstLastButtons: true,
            renderEmptyRowsInTheEnd: false,
            onRowsPerPageChanged: (noOfRows){},
            headingTextStyle: Theme.of(context).textTheme.titleMedium,
            headingRowColor: MaterialStateProperty.resolveWith((state) => fColors.primaryBackground),
            empty: fAnimationLoaderWidget(text: "Nothing Found", image: fImages.Animation1,height: 200,width: 200),
            headingRowDecoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(fSizes.borderRadiusMd),
                topRight: Radius.circular(fSizes.borderRadiusMd),
              )

            ),

            /// SORTTING
            sortAscending: sortAscending,
            sortColumnIndex: sortColumnIndex,
            sortArrowBuilder: (bool ascending, bool sorted) {
              if(sorted){
                return Icon(ascending? Iconsax.arrow_up_3 : Iconsax.arrow_down, size: fSizes.iconSm,);
              } else {
                return const Icon(Iconsax.arrow_3,size: fSizes.iconSm,);

              }

            },
          )),
    );
  }
}
