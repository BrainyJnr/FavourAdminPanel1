import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/common/widgets/data_table/ftable_action_table.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../utilis/constants/colors.dart';
import '../../../../../utilis/constants/image_strings.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../model/product_model.dart';

class ProductsRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(Row(
          children: [
            const fRoundedImage(
              width: 50,
              height: 50,
              padding: fSizes.xs,
              image: fImages.Acer,
              imageType: ImageType.asset,
              borderRadius: fSizes.borderRadiusMd,
              backgroundColor: fColors.primaryBackground,
            ),
            const SizedBox(
              width: fSizes.spaceBtwItems,
            ),
            Flexible(
                child: Text(
              "Product Title",
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge!
                  .apply(color: fColors.primary),
              overflow: TextOverflow.ellipsis,
            ))
          ],
        )),
        const DataCell(Text("256")),

        // Brand
        DataCell(Row(
          children: [
            fRoundedImage(
              padding: fSizes.xs,
              width: 35,
              height: 35,
              image: fImages.Acer,
              imageType: ImageType.asset,
              borderRadius: fSizes.borderRadiusMd,
              backgroundColor: fColors.primaryBackground,
            ),
            const SizedBox(
              width: fSizes.spaceBtwItems,
            ),
            Flexible(
                child: Text(
              "Nike",
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyMedium!
                  .apply(color: fColors.primary),
            ))
          ],
        )),

        const DataCell(Text("\$99.9")),

        DataCell(Text(DateTime.now().toString())),

        DataCell(
          fTableActionButton(
            onEditPressed: () => Get.toNamed(fRoutes.editProduct,arguments: ProductModel.empty()),

            onDeletePressed: (){},
          )
        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
