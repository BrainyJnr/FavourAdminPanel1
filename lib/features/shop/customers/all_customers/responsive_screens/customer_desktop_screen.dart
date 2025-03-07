import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/common/widgets/loaders/fanimation.dart';
import 'package:favour_adminpanel/features/shop/customers/controller/customer_controller.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/data_table/table_header.dart';
import '../table/data_table.dart';

class CustomerDesktopScreen extends StatelessWidget {
  const CustomerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BreadCrumbs
            fBreadCrumbsWithHeading(heading: "Customers", breadcrumbItems: ['Customers']),
            SizedBox(height: fSizes.spaceBtwSections,),

            fRoundedContainer(
              child: Column(
                children: [
                // Table Header
                TableHeader(showLeftWidget: false,
                searchController: controller.searchTextController,
                searchChanged: (query) => controller.searchQuery(query),),
                  SizedBox(height: fSizes.spaceBtwItems,),

                  // Table
                  Obx(() {
                    // Show Loader
                    if (controller.isLoading.value)
                      return const fLoaderAnimation();
                    return const CustomerTable();
                  })

                ]            )
            )],
        ),),
      ),
    );
  }
}
