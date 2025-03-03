import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/common/widgets/data_table/ftable_action_table.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utilis/constants/enums.dart';
import '../../controller/product_controller.dart';


class ProductsRows extends DataTableSource {
  final controller = ProductController.instance;

  @override
  DataRow? getRow(int index) {
    final product = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(fRoutes.editProduct, arguments: product),
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              fRoundedImage(
                width: 50,
                height: 50,
                padding: fSizes.xs,
                image: product.thumbnail,
                imageType: ImageType.network,
                borderRadius: fSizes.borderRadiusMd,
                backgroundColor: fColors.primaryBackground,
              ),
              const SizedBox(width: fSizes.spaceBtwItems),
              Flexible(child: Text(product.title, style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: fColors.primary))),
            ],
          ),
        ),
        DataCell(Text(controller.getProductStockTotal(product))),
        DataCell(Text(controller.getProductSoldQuantity(product))),
        DataCell(
          Row(
            children: [
              fRoundedImage(
                width: 35,
                height: 35,
                padding: fSizes.xs,
                borderRadius: fSizes.borderRadiusMd,
                backgroundColor: fColors.primaryBackground,
                imageType: product.brand != null ? ImageType.network : ImageType.asset,
                image: product.brand != null ? product.brand!.image : fImages.Acer,
              ),
              const SizedBox(width: fSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  product.brand != null ? product.brand!.name : '',
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: fColors.primary),
                ),
              ),
            ],
          ),
        ),
        DataCell(Text('\$${controller.getProductPrice(product)}')),
        DataCell(Text(product.formattedDate)),
        DataCell(
          fTableActionButton(
            onEditPressed: () => Get.toNamed(fRoutes.editProduct, arguments: product),
            onDeletePressed: () => controller.confirmDelete(product),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
