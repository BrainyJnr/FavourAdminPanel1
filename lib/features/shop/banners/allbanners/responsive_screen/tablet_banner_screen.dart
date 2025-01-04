import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/styles/frounded_container.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../table/banner_table.dart';

class TabletBannerScreen extends StatelessWidget {
  const TabletBannerScreen({super.key});

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
