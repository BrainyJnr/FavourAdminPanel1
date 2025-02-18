import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/styles/frounded_container.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../common/widgets/loaders/fanimation.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../controller/product_controller.dart';
import '../table/product_table.dart';

class ProductTabletScreen extends StatelessWidget {
  const ProductTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BreadCrumbs
              const fBreadCrumbsWithHeading(heading: "Products", breadcrumbItems: ["Products"]),
              const SizedBox(height: fSizes.spaceBtwSections,),

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
          ),),
      ),
    );
  }
}
