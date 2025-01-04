import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:flutter/material.dart';

import '../../../../../utilis/constants/image_strings.dart';
import '../../../../../utilis/constants/sizes.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key});

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Thumbnail Text
          Text(
            "Product Thumbnail",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: fSizes.spaceBtwItems,
          ),

          // Container for Product Thumbnail
          fRoundedContainer(
            height: 300,
            backgroundColor: fColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thumbnail Image
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: fRoundedImage(
                        padding: fSizes.chi,
                        height: 220,
                        width: 220,
                        image: fImages.Acer,
                        imageType: ImageType.asset,
                      ))
                    ],
                  ),

                  // Add Thumbnail Button
                  SizedBox(
                    width: 200,
                    child: OutlinedButton(
                        onPressed: () {}, child: Text("Add Thumbnail")),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
