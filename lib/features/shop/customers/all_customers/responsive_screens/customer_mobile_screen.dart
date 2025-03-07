import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/styles/frounded_container.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../common/widgets/loaders/fanimation.dart';
import '../../../../../features_authentication/models/user_model.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../controller/customer_controller.dart';
import '../../customer_detail/widgets/customer_info.dart';
import '../../customer_detail/widgets/customer_orders.dart';
import '../../customer_detail/widgets/customer_shipping_address.dart';
import '../table/data_table.dart';
import 'package:flutter/material.dart';

class CustomerMobileScreen extends StatelessWidget {
  const CustomerMobileScreen({super.key,});


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
                fBreadCrumbsWithHeading(
                    heading: "Customers", breadcrumbItems: ['Customers']),
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

                        ])
                )
              ],
            ),),
        )

    );
  }
}
