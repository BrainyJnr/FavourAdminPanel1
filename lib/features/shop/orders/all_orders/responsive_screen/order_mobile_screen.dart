import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get.dart';
import '../../../../../common/styles/frounded_container.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../common/widgets/loaders/fanimation.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../controller/order_controller.dart';
import '../../model/order_model.dart';
import '../table/data_table.dart';

class OrderMobileScreen extends StatelessWidget {
  const OrderMobileScreen({super.key, required this.order});

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
