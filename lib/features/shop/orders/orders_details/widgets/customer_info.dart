import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/features/shop/dashboard/controller/dashboard_controller.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../utilis/constants/colors.dart';

class CustomerInfoOrder extends StatelessWidget {
  const CustomerInfoOrder({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info
        fRoundedContainer(
          padding: const EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Customer",style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: fSizes.spaceBtwSections,),
              Row(
                children: [
                   fRoundedImage(padding: fSizes.chi,
                  backgroundColor: fColors.primaryBackground,
                   imageType: ImageType.asset,image: fImages.Profile2,),
                  const SizedBox(width: fSizes.spaceBtwItems,),
                  Expanded(child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Coding with T",style: Theme.of(context).textTheme.titleLarge,overflow: TextOverflow.ellipsis,maxLines: 1,),
                      const Text("godwinchimdikefavour@gmail.com",overflow: TextOverflow.ellipsis,maxLines: 1,)


                    ],
                  ))
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: fSizes.spaceBtwSections,),

        // Contact Info
        SizedBox(
          width: double.infinity,
          child: fRoundedContainer(
            padding: const EdgeInsets.all(fSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Contact Person",style: Theme.of(context).textTheme.headlineMedium,),
                const SizedBox(height: fSizes.spaceBtwSections / 2,),
                Text("Coding With T",style: Theme.of(context).textTheme.titleSmall,),
                const SizedBox(height: fSizes.spaceBtwSections / 2,),
                Text("godwinchimdikefavour@gmail.com",style: Theme.of(context).textTheme.titleSmall,),
                const SizedBox(height: fSizes.spaceBtwSections / 2,),
                Text("+234",style: Theme.of(context).textTheme.titleSmall,),

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
                Text("Shipping Address",style: Theme.of(context).textTheme.headlineMedium,),
                const SizedBox(height: fSizes.spaceBtwSections,),
                Text("Brainy's LTD",style: Theme.of(context).textTheme.titleSmall,),
                const SizedBox(height: fSizes.spaceBtwSections / 2,),
                Text("12 Douglas Street, Enugu, Nigeria",style: Theme.of(context).textTheme.titleSmall,),
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
                Text("Shipping Address",style: Theme.of(context).textTheme.headlineMedium,),
                const SizedBox(height: fSizes.spaceBtwSections,),
                Text("Brainy's LTD",style: Theme.of(context).textTheme.titleSmall,),
                const SizedBox(height: fSizes.spaceBtwSections / 2,),
                Text("12 Douglas Street, Enugu, Nigeria",style: Theme.of(context).textTheme.titleSmall,),
              ],
            ),
          ),
        ),
        const SizedBox(height: fSizes.spaceBtwSections,),

      ],
    );
  }
}
