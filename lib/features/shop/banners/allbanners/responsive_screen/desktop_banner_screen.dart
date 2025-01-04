import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/common/widgets/data_table/table_header.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../table/banner_table.dart';

class DesktopBannerScreen extends StatelessWidget {
  const DesktopBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
        child: Column(
          children: [
            // breadcrumbs
            fBreadCrumbsWithHeading(heading: "Banners", breadcrumbItems: ["Banners"]),
            SizedBox(height: fSizes.spaceBtwSections,),

            fRoundedContainer(
              child: Column(
                children: [
                  // Table Header
                  TableHeader(buTTonText: "Create New Banner",onPressed: () => Get.toNamed(fRoutes.createBanner),),
                  SizedBox(height: fSizes.spaceBtwItems,),

                  // Table
                  const BannersTable()
                ],
              ),
            )
          ],
        ),),
      ),
    );
  }
}
