import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/common/widgets/data_table/ftable_action_table.dart';
import 'package:favour_adminpanel/features/shop/banners/model/banner_model.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../controller/banner_controller.dart';

class BannerRow extends DataTableSource {
  final controller = BannerController.instance;

  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(fRoutes.editBanner, arguments: banner),
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(fRoundedImage(
          width: 180,
          height: 100,
          padding: fSizes.sm,
          image: banner.imageUrl,
          imageType: ImageType.network,
          borderRadius: fSizes.borderRadiusMd,
          backgroundColor: fColors.primaryBackground,
        )),
        DataCell(Text(controller.formatRoute(banner.targetScreen))),
        DataCell(
          banner.active
              ? const Icon(Iconsax.eye, color: fColors.primary)
              : const Icon(Iconsax.eye_slash),
        ),
        DataCell(fTableActionButton(
          onEditPressed: () =>
              Get.toNamed(fRoutes.editBanner, arguments: banner),
          onDeletePressed: () => controller.confirmDelete(banner),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
