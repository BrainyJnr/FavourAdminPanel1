import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/common/widgets/data_table/ftable_action_table.dart';
import 'package:favour_adminpanel/features_authentication/models/user_model.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomerRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
        cells: [
      DataCell(Row(
        children: [
          fRoundedImage(
            width: 50,
            height: 50,
            padding: fSizes.sm,
            image: fImages.Kitchen,
            imageType: ImageType.asset,
            borderRadius: fSizes.borderRadiusLg,
            backgroundColor: fColors.primaryBackground,
          ),
          const SizedBox(
            width: fSizes.spaceBtwItems,
          ),
          Expanded(
              child: Text(
            "Favour",
            style: Theme.of(Get.context!)
                .textTheme
                .bodyLarge!
                .apply(color: fColors.primary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ))
        ],
      )),
          const DataCell(Text("godwinchimdikefavour@gmail.com")),
          const DataCell(Text("+488-8888-8884")),
          DataCell(Text(DateTime.now().toString())),
          DataCell(fTableActionButton(
            view: true,
            edit: false,
            onViewPressed: () => Get.toNamed(fRoutes.customerDetails,arguments: UserModel.empty()),
            onDeletePressed: () {},
          ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
}
