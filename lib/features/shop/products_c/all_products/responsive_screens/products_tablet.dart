import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/common/widgets/loaders/fanimation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../controller/product_controller.dart';
import '../table/products_table.dart';
import '../widgets/table_header.dart';

class ProductsTabletScreen extends StatelessWidget {
  const ProductsTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const fBreadCrumbsWithHeading(heading: 'Products', breadcrumbItems: ['Products']),
              const SizedBox(height: fSizes.spaceBtwSections), // Table Body

              // Table Body
              Obx(() {
                // Show Loader
                if (controller.isLoading.value) return const fLoaderAnimation();

                return const fRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      ProductTableHeader(),
                      SizedBox(height: fSizes.spaceBtwItems),

                      // Table
                      ProductsTable(),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
