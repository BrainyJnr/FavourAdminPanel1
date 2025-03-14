import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/styles/frounded_container.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../common/widgets/loaders/fanimation.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../controller/brand_controller.dart';
import '../table/data_table.dart';

class BrandsMobileScreen extends StatelessWidget {
  const BrandsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(fSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const fBreadCrumbsWithHeading(
                    heading: "Brands", breadcrumbItems: ['Brands']),
                const SizedBox(
                  height: fSizes.spaceBtwSections,
                ),
                fRoundedContainer(
                  child: Column(
                    children: [
                      TableHeader(
                        buTTonText: "Create New Brand",
                        onPressed: () => Get.toNamed(fRoutes.createBrand),
                        searchController: controller.searchTextController,
                        searchChanged: (query) => controller.searchQuery(query),
                      ),
                      const SizedBox(height: fSizes.spaceBtwSections,),

                      // Table
                      Obx(() {
                        if(controller.isLoading.value) return const fLoaderAnimation();
                        return BrandTable();})
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
