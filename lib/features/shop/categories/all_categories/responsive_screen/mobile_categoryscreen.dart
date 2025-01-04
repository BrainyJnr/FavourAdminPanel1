import 'package:flutter/material.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/data_table/table_header.dart';
import '../table/category_table.dart';

class MobileCategoryscreen extends StatelessWidget {
  const MobileCategoryscreen({super.key});

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
