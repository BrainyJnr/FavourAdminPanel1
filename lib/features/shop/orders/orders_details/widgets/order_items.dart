import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/features/shop/dashboard/controller/dashboard_controller.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:favour_adminpanel/utilis/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.items.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity));
    return fRoundedContainer(
      padding: EdgeInsets.all(fSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Items",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: fSizes.spaceBtwSections,
          ),

          // Item
          ListView.separated(
            shrinkWrap: true,
            itemCount: order.items.length,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(
              height: fSizes.spaceBtwItems,
            ),
            itemBuilder: (_, index) {
              final item = order.items[index];
              return Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      fRoundedImage(
                        padding: fSizes.chi,
                        backgroundColor: fColors.primaryBackground,
                        image: item.image ?? fImages.Orange2,
                        imageType: item.image != null
                            ? ImageType.network
                            : ImageType.asset,
                      ),
                      const SizedBox(
                        width: fSizes.spaceBtwItems,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          if (item.selectedVariation != null)
                            Text(item.selectedVariation!.entries
                                .map((e) => ('${e.key} : ${e.value}'))
                                .toString())
                        ],
                      ))
                    ],
                  )),
                  const SizedBox(width: fSizes.spaceBtwItems,),
                  SizedBox(
                    width: fSizes.xl * 2,
                    child: Text('\$${item.price.toStringAsFixed(1)}', style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                  SizedBox(
                    width: fDeviceUtilis.isMobileScreen(context) ? fSizes.xl * 1.4: fSizes.xl * 2,
                    child: Text(item.quantity.toString(), style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                  SizedBox(
                    width: fDeviceUtilis.isMobileScreen(context) ? fSizes.xl * 1.4: fSizes.xl * 2,
                    child: Text('\$${item.totalAmount}', style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: fSizes.spaceBtwSections,),

          // Items Total
          fRoundedContainer(
            padding: const EdgeInsets.all(fSizes.defaultSpace),
            backgroundColor: fColors.primaryBackground,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal",style: Theme.of(context).textTheme.titleMedium,),
                    Text("\$$subTotal",style: Theme.of(context).textTheme.titleMedium,),
                  ],
                ),SizedBox(height: fSizes.spaceBtwItems,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount",style: Theme.of(context).textTheme.titleMedium,),
                    Text("\$0.00",style: Theme.of(context).textTheme.titleMedium,),
                  ],
                ),
                SizedBox(height: fSizes.spaceBtwItems,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shipping",style: Theme.of(context).textTheme.titleMedium,),
                    Text('\$${fPricingCalculator.calculateShippingCost(subTotal, '')}',
                    style: Theme.of(context).textTheme.titleMedium,)

                  ],
                ),

                const SizedBox(
                  height: fSizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tax",style: Theme.of(context).textTheme.titleMedium,),
                    Text('\$${fPricingCalculator.calculateTax(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleMedium,)
                  ],
                ),
                const SizedBox(height: fSizes.spaceBtwItems,),
                const Divider(),
                const SizedBox(height: fSizes.spaceBtwItems,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total",style: Theme.of(context).textTheme.titleMedium,),
                    Text('\$${fPricingCalculator.calculateTotalPrice(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleMedium,)
                  ],
                )


              ],
            ),
          )
        ],
      ),
    );
  }
}
