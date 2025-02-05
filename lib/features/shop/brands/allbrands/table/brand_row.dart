import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/common/widgets/data_table/ftable_action_table.dart';
import 'package:favour_adminpanel/features/shop/brands/controller/brand_controller.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utilis/constants/colors.dart';
import '../../../../../utilis/constants/image_strings.dart';
import '../../../../../utilis/constants/sizes.dart';

class BrandsRows extends DataTableSource {
  final controller = BrandController.instance;
  @override
  DataRow? getRow(int index) {
    final brand = controller.filteredItems[index];
    return DataRow2(
        selected: controller.selectedRows[index],
        onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
        cells: [
      DataCell(Row(children: [
        fRoundedImage(
            width: 50,
            height: 58,
            image: brand.image,
            imageType: ImageType.network,
            borderRadius: fSizes.borderRadiusMd,
            backgroundColor: fColors.primaryBackground,
            padding: fSizes.sm),
        const SizedBox(
          width: fSizes.spaceBtwItems,
        ),
        Expanded(
            child: Text(
          brand.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(Get.context!)
              .textTheme
              .bodyMedium!
              .apply(color: fColors.primary),
        ))
      ])),
      DataCell(
          Padding(
        padding: EdgeInsets.symmetric(vertical: fSizes.sm),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            spacing: fSizes.xs,
            direction: fDeviceUtilis.isMobileScreen(Get.context!)
                ? Axis.vertical
                : Axis.horizontal,
            children:  brand.brandCategories != null
            ? brand.brandCategories!.map((e) =>
              Padding(
                padding: EdgeInsets.only(
                    bottom: fDeviceUtilis.isMobileScreen(Get.context!)
                        ? 0
                        : fSizes.xs),
                child: Chip(
                  label: Text(e.name),
                  padding: EdgeInsets.all(fSizes.xs)),
                ),
              ).toList() : [const SizedBox()],
    )))),
          DataCell(brand.isFeatured ? const Icon(Iconsax.heart5,color: fColors.primary,) : Icon(Iconsax.heart)),
      DataCell(Text(brand.createdAt != null ? brand.formattedDate : "")),
      DataCell(
        fTableActionButton(
          onEditPressed: () => Get.toNamed(fRoutes.editBrand,arguments: brand),
          onDeletePressed: () => controller.confirmDelete(brand),
        )
      )
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
