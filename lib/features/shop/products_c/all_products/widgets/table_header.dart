import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controller/product_controller.dart';


class ProductTableHeader extends StatelessWidget {
  const ProductTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Row(
      children: [
        Expanded(
          flex: !fDeviceUtilis.isDesktopScreen(context) ? 1 : 3,
          child: Row(
            children: [
              SizedBox(
                width: 140,
                child: ElevatedButton(onPressed: () => Get.toNamed(fRoutes.createProduct), child: const Text('Add Product')),
              ),
            ],
          ),
        ),
        Expanded(
          flex: fDeviceUtilis.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: controller.searchTextController,
            onChanged: (query) => controller.searchQuery(query),
            decoration: const InputDecoration(hintText: 'Search', prefixIcon: Icon(Iconsax.search_normal)),
          ),
        ),
      ],
    );
  }
}
