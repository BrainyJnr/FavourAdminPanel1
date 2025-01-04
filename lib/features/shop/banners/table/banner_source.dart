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

class BannerRow extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(fRoundedImage(
          width: 180,
          height: 100,
          padding: fSizes.sm,
          image: fImages.Acer,
          imageType: ImageType.asset,
          borderRadius: fSizes.borderRadiusMd,
          backgroundColor: fColors.primaryBackground,
        )),
        const DataCell(Text("Shop")),
        DataCell(Icon(
          Iconsax.eye,
          color: fColors.primary,
        )),
        DataCell(fTableActionButton(
          onEditPressed: () => Get.toNamed(fRoutes.editBanner,
              arguments: BannerModel(
                imageUrl: "",
                targetScreen: "",
                active: false,
              )),
          onDeletePressed: () {},
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 20;

  @override
  int get selectedRowCount => 0;
}
