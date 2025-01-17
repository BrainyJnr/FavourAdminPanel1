import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/features_authentication/models/user_model.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      padding: EdgeInsets.all(fSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Information",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: fSizes.spaceBtwSections,
          ),

          // Personal Info Card
          Row(
            children: [
              fRoundedImage(
                padding: 3,
                backgroundColor: fColors.primaryBackground,
                imageType: ImageType.asset,
                image: fImages.Profile1,
              ),
              const SizedBox(
                width: fSizes.spaceBtwItems,
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Godwin Chimdike Favour",
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const Text(
                    "godwinchimdikefavour@gmail.com",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              ))
            ],
          ),
          SizedBox(
            height: fSizes.spaceBtwSections,
          ),

          // Meta Data
          Row(
            children: [
              SizedBox(
                width: 128,
                child: Text("UsernMAE"),
              ),
              Text(":"),
              SizedBox(
                width: fSizes.spaceBtwSections / 2,
              ),
              Expanded(
                  child: Text(
                "GCF",
                style: Theme.of(context).textTheme.titleSmall,
              ))
            ],
          ),
          const SizedBox(
            height: fSizes.spaceBtwItems,
          ),
          Row(
            children: [
              const SizedBox(
                width: 128,
                child: Text("Country"),
              ),
              const Text(":"),
              const SizedBox(
                width: fSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text(
                "United Kingdom",
                style: Theme.of(context).textTheme.titleSmall,
              ))
            ],
          ),

          const SizedBox(
            height: fSizes.spaceBtwItems,
          ),
          Row(
            children: [
              const SizedBox(
                width: 128,
                child: Text("Phone Number"),
              ),
              const Text(":"),
              const SizedBox(
                width: fSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text(
                "+32-2333-23422",
                style: Theme.of(context).textTheme.titleSmall,
              ))
            ],
          ),
          const SizedBox(
            height: fSizes.spaceBtwItems,
          ),

          // Divider
          const Divider(),
          const SizedBox(
            height: fSizes.spaceBtwItems,
          ),

          // Additional Details
          Row(
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Last Order",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Text("14 Days Ago, #[389r3]")
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Average Order Value",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Text("\$2442")
                ],
              ))
            ],
          ),
          const SizedBox(
            height: fSizes.spaceBtwItems,
          ),

          // Additional Details C
          Row(
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Registered",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              )),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email Marketing",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Text("Subscribed")
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
