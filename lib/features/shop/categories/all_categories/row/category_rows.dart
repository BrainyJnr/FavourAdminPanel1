import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/data_table/ftable_action_table.dart';
import '../../../../../utilis/constants/colors.dart';
import '../../../../../utilis/constants/sizes.dart';

class CategoryRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
        cells: [
          DataCell(
              Row(
                children: [
                  fRoundedImage(
                    width: 50,
                    height: 50,
                    padding: fSizes.sm,
                    image: fImages.Acer,
                    imageType: ImageType.network,
                    borderRadius: fSizes.borderRadiusMd,
                    backgroundColor: fColors.primaryBackground,
                  ),
                  const SizedBox(width: fSizes.spaceBtwItems,),
                  Expanded(child: Text("Name",
                    style: Theme
                        .of(Get.context!)
                        .textTheme
                        .bodyLarge!
                        .apply(color: fColors.primary),
                    maxLines: 2, overflow: TextOverflow.ellipsis,))
                ],
              )
          ),
          DataCell(Text("Parent")),
          DataCell(Icon(Iconsax.heart5,color: fColors.primary,)),
          DataCell(Text(DateTime.now().toString(),)),
          DataCell(fTableActionButton(
            onEditPressed: () => Get.toNamed(fRoutes.editCategory,arguments: "Category"),
            onDeletePressed: (){},

          ))
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}
