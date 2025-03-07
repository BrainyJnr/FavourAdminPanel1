import 'package:data_table_2/data_table_2.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/common/widgets/data_table/ftable_action_table.dart';
import 'package:favour_adminpanel/features/shop/customers/controller/customer_controller.dart';
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
  final controller = CustomerController.instance;

  @override
  DataRow? getRow(int index) {
    final customer = controller.filteredItems[index];
    return DataRow2(
      onTap: () => Get.toNamed(fRoutes.customerDetails, arguments: customer, parameters: {"customerId" : customer.id ?? ""}),
        selected: controller.selectedRows[index],
        onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
        cells: [
      DataCell(Row(
        children: [
          fRoundedImage(
            width: 50,
            height: 50,
            padding: fSizes.sm,
            image: customer.profilePicture,
            imageType: ImageType.network,
            borderRadius: fSizes.borderRadiusLg,
            backgroundColor: fColors.primaryBackground,
          ),
          const SizedBox(
            width: fSizes.spaceBtwItems,
          ),
          Expanded(
              child: Text(
            customer.fullName,
            style: Theme.of(Get.context!)
                .textTheme
                .bodyLarge!
                .apply(color: fColors.primary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ))
        ],
      )),
           DataCell(Text(customer.email)),
           DataCell(Text(customer.phoneNumber)),
          DataCell(Text(customer.createAt == null ? "" : customer.formattedDate)),
          DataCell(fTableActionButton(
            view: true,
            edit: false,
            onViewPressed: () => Get.toNamed(fRoutes.customerDetails,arguments: customer, parameters:  {"customerId": customer.id ?? ""}),
            onDeletePressed: () => controller.confirmDelete(customer),
          ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
