import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/common/widgets/data_table/table_header.dart';
import 'package:favour_adminpanel/common/widgets/loaders/fanimation.dart';
import 'package:favour_adminpanel/features/shop/orders/controller/order_controller.dart';
import 'package:favour_adminpanel/features/shop/orders/model/order_model.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../table/data_table.dart';

class OrderDesktopScreen extends StatelessWidget {
  const OrderDesktopScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BreadCrumbs
            fBreadCrumbsWithHeading(heading: "Orders", breadcrumbItems: ['Orders']),
            SizedBox(height: fSizes.spaceBtwSections,),

            // Table Body
            fRoundedContainer(
              child: Column(
                children: [
                  // Table Header
                  TableHeader(showLeftWidget: false,
                    searchController: controller.searchTextController,
                    searchChanged: (query) =>
                        controller.searchQuery(query),),

                  // Table
                  Obx((){
                    if (controller.isLoading.value) return const fLoaderAnimation();
                   return OrderTable();
                  })
                ],
              ),
            )

          ],
        ),),
      ),
    );
  }
}
