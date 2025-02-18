import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/common/widgets/data_table/table_header.dart';
import 'package:favour_adminpanel/common/widgets/loaders/fanimation.dart';
import 'package:favour_adminpanel/features/shop/products/controller/product_controller.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../table/product_table.dart';

class ProductDesktopScreen extends StatelessWidget {
  const ProductDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BreadCrumbs
              const fBreadCrumbsWithHeading(
                  heading: "Products", breadcrumbItems: ["Products"]),
              const SizedBox(
                height: fSizes.spaceBtwSections,
              ),

              // Table Body
              Obx(() {
                if (controller.isLoading.value) return const fLoaderAnimation();

                return fRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      TableHeader(
                        buTTonText: "Create Products",
                        onPressed: () => Get.toNamed(fRoutes.createProduct),
                        searchChanged: (query) => controller.searchQuery(query),
                      ),
                      const SizedBox(
                        height: fSizes.spaceBtwItems,
                      ),

                      // Table
                      const ProductTable()
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
