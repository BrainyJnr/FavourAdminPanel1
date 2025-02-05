import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/features/shop/controller/category_controller.dart';
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
  final controller = CategoryController.instance;
  @override
  DataRow? getRow(int index) {
    final category = controller.filteredItems[index];
    final parentCategory = controller.allItems.firstWhereOrNull((item) => item.id == category.parentId);
    return DataRow2(
      selected: controller.selectedRows[index],
        onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
        cells: [
          DataCell(
              Row(
                children: [
                  fRoundedImage(
                    width: 50,
                    height: 50,
                    padding: fSizes.sm,
                    image: category.image,
                    imageType: ImageType.network,
                    borderRadius: fSizes.borderRadiusMd,
                    backgroundColor: fColors.primaryBackground,
                  ),
                  const SizedBox(width: fSizes.spaceBtwItems,),
                  Expanded(child: Text( category.name,
                    style: Theme
                        .of(Get.context!)
                        .textTheme
                        .bodyLarge!
                        .apply(color: fColors.primary),
                    maxLines: 2, overflow: TextOverflow.ellipsis,))
                ],
              )
          ),
          DataCell(Text(parentCategory != null ? parentCategory.name : "")),
          DataCell(category.isFeatured ? const Icon(Iconsax.heart5,color: fColors.primary,) : const Icon(Iconsax.heart)),
          DataCell(Text(category.createdAt == null ? "" : category.formattedCreatedDate)),
          DataCell(fTableActionButton(
            onEditPressed: () => Get.toNamed(fRoutes.editCategory,arguments: category),
            onDeletePressed: () => controller.confirmDelete(category),

          ))
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => 0;
}
