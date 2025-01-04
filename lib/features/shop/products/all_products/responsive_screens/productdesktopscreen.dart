import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/common/widgets/data_table/table_header.dart';
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
            fRoundedContainer(
              child: Column(
                children: [
                  // Table Header
                  TableHeader(buTTonText: "Add Products",onPressed: () => Get.toNamed(fRoutes.createProduct),),
                  const SizedBox(height: fSizes.spaceBtwItems,),

                  // Table
                  const ProductTable()
                ],
              ),
            )
          ],
        ),),
      ),
    );
  }
}
