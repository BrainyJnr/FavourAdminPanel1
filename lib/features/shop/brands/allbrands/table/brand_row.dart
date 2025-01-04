import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/common/widgets/data_table/ftable_action_table.dart';
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
  @override
  DataRow? getRow(int index) {
    return DataRow2(cells: [
      DataCell(Row(children: [
        const fRoundedImage(
            width: 50,
            height: 58,
            image: fImages.Acer,
            imageType: ImageType.asset,
            borderRadius: fSizes.borderRadiusMd,
            backgroundColor: fColors.primaryBackground,
            padding: fSizes.sm),
        const SizedBox(
          width: fSizes.spaceBtwItems,
        ),
        Expanded(
            child: Text(
          "Adidas",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(Get.context!)
              .textTheme
              .bodyMedium!
              .apply(color: fColors.primary),
        ))
      ])),
      DataCell(Padding(
        padding: EdgeInsets.symmetric(vertical: fSizes.sm),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            spacing: fSizes.xs,
            direction: fDeviceUtilis.isMobileScreen(Get.context!)
                ? Axis.vertical
                : Axis.horizontal,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: fDeviceUtilis.isMobileScreen(Get.context!)
                        ? 0
                        : fSizes.xs),
                child: Chip(
                  label: Text("Shoes"),
                  padding: EdgeInsets.all(fSizes.xs),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: fDeviceUtilis.isMobileScreen(Get.context!)
                        ? 0
                        : fSizes.xs),
                child: Chip(
                  label: Text("TrackSuits"),
                  padding: EdgeInsets.all(fSizes.xs),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: fDeviceUtilis.isMobileScreen(Get.context!)
                        ? 0
                        : fSizes.xs),
                child: Chip(
                  label: Text("Joggers"),
                  padding: EdgeInsets.all(fSizes.xs),
                ),
              ),
            ],
          ),
        ),
      )),
      const DataCell(Icon(Iconsax.heart5,color: fColors.primary,)),
      DataCell(Text(DateTime.now().toString())),
      DataCell(
        fTableActionButton(
          onEditPressed: () => Get.toNamed(fRoutes.editBrand,arguments: ''),
          onDeletePressed: (){},
        )
      )
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 20;

  @override
  int get selectedRowCount => 0;
}
