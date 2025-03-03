import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/features/shop/orders/controller/order_controller.dart';
import 'package:favour_adminpanel/features/shop/orders/controller/order_detail_controller.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../utilis/constants/colors.dart';
import '../../model/order_model.dart';

class CustomerInfoOrder extends StatelessWidget {
  const CustomerInfoOrder({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info
        fRoundedContainer(
            padding: const EdgeInsets.all(fSizes.defaultSpace),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Customer", style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium,),
                  const SizedBox(height: fSizes.spaceBtwSections,),
                  Obx(
                          () {
                        return Row
                          (
                            children: [
                              fRoundedImage(padding: fSizes.chi,
                                backgroundColor: fColors.primaryBackground,
                                imageType: controller.customer.value
                                    .profilePicture.isNotEmpty ? ImageType
                                    .network : ImageType.asset,
                                image: controller.customer.value.profilePicture
                                    .isNotEmpty
                                    ?
                                controller.customer.value.profilePicture
                                    : fImages.Profile2,),
                              const SizedBox(width: fSizes.spaceBtwItems,),
                              Expanded(child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(controller.customer.value.phoneNumber,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,),
                                  Text(controller.customer.value.email.isNotEmpty
                                      ? controller.customer.value.email
                                      : "No email found")



                            ],
                              )

                              )
                            ]);
                      })
                ])
        )
      ,

      const SizedBox(height: fSizes.spaceBtwSections,),

      // Contact Info
      Obx(
        () => SizedBox(
          width: double.infinity,
          child: fRoundedContainer(
            padding: const EdgeInsets.all(fSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Contact Person", style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,),
                const SizedBox(height: fSizes.spaceBtwSections / 2,),
                Text(controller.customer.value.fullName, style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,),
                const SizedBox(height: fSizes.spaceBtwSections / 2,),
                Text(controller.customer.value.email, style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,),
                const SizedBox(height: fSizes.spaceBtwSections / 2,),
                Text(
                  controller.customer.value.formattedPhoneNo.isNotEmpty ?
                      controller.customer.value.formattedPhoneNo :
                  "+234", style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,),

              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: fSizes.spaceBtwSections,),

      SizedBox(
        width: double.infinity,
        child: fRoundedContainer(
          padding: const EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Shipping Address", style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,),
               SizedBox(height: fSizes.spaceBtwSections,),
              Text(order.shippingAddress !=null ? order.shippingAddress!.name : "", style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall,),
               SizedBox(height: fSizes.spaceBtwSections / 2,),
              Text(order.shippingAddress != null ? order.shippingAddress!.toString() : "", style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall,),
            ],
          ),
        ),
      ),
      const SizedBox(height: fSizes.spaceBtwSections,),

      SizedBox(
        width: double.infinity,
        child: fRoundedContainer(
          padding: const EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Billing Address", style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,),
              const SizedBox(height: fSizes.spaceBtwSections,),
              Text(order.billingAddressSameAsShipping  ? order.shippingAddress!.name : order.billingAddress!.name, style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall,),
              const SizedBox(height: fSizes.spaceBtwSections / 2,),
              Text(order.billingAddressSameAsShipping ? order.shippingAddress!.toString() : order.billingAddress!.toString(), style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall,),
            ],
          ),
        ),
      ),
      const SizedBox(height: fSizes.spaceBtwSections,),

  ]  );
  }
}


