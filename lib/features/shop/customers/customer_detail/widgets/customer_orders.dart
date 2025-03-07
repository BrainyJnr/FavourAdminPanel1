import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/loaders/fAnimationLoaderWidget.dart';
import 'package:favour_adminpanel/common/widgets/loaders/fanimation.dart';
import 'package:favour_adminpanel/features/shop/customers/customer_detail/controller/customer_detail_controller.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../table/data_table.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerOrders();
    return fRoundedContainer(
      padding: EdgeInsets.all(fSizes.defaultSpace),
      child: Obx(
        () {
          if(controller.ordersLoading.value) return const fLoaderAnimation();
          if(controller.allCustomerOrders.isEmpty) {
            return const fAnimationLoaderWidget(text: "No Orders Found", image: fImages.Animation1);
          }

          final totalAmount = controller.allCustomerOrders.fold(0.0, (previousValue, element) => previousValue + element.totalAmount);
        return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Orders",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: "Total Spent"),
                    TextSpan(
                        text: " \$${totalAmount.toString()}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: fColors.primary)),
                    TextSpan(
                        text: ' on ${controller.allCustomerOrders.length} Orders',
                        style: Theme.of(context).textTheme.bodyMedium)
                  ]))
                ],
              ),
              SizedBox(
                height: fSizes.spaceBtwItems,
              ),
              TextFormField(
                onChanged: (query) => controller.searchQuery(query),
                controller: controller.searchTextController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black12, // Border color when enabled
                      width: 1.5,
                    ),
                  ),
                  hintText: "Search Order",
                  prefixIcon: Icon(Iconsax.search_normal),
                  enabledBorder: OutlineInputBorder(
                    // Border when not focused
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black12, // Border color when enabled
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: fSizes.spaceBtwSections,
              ),
              CustomerOrderTable()
            ],
          );
        },
      ),
    );
  }
}
