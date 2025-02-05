import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/common/widgets/data_table/table_header.dart';
import 'package:favour_adminpanel/common/widgets/loaders/fanimation.dart';
import 'package:favour_adminpanel/features/shop/brands/controller/brand_controller.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../table/data_table.dart';

class BrandsDesktopScreen extends StatelessWidget {
  const BrandsDesktopScreen({super.key});

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
                    if(controller.isLoading.value) return fLoaderAnimation();
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
