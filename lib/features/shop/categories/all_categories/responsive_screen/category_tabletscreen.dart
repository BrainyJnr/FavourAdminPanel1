import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/styles/frounded_container.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../table/category_table.dart';

class CategoryTabletscreen extends StatelessWidget {
  const CategoryTabletscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const fBreadCrumbsWithHeading(
                  heading: "Categories", breadcrumbItems: ["Categories"]),
              const SizedBox(
                height: fSizes.spaceBtwSections,
              ),
              fRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TableHeader(buTTonText: "Create New Category",onPressed: () => Get.toNamed(fRoutes.createCategory),),
                    SizedBox(
                      height: fSizes.spaceBtwItems,
                    ),

                    // Table
                    CategoryTable()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
