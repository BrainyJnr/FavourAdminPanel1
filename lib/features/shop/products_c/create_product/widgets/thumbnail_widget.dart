import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utilis/constants/colors.dart';
import '../../../../../utilis/constants/enums.dart';
import '../../../../../utilis/constants/image_strings.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../controller/product_images_controller.dart';


class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProductImagesController controller = Get.put(ProductImagesController());

    return fRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Thumbnail Text
          Text('Product Thumbnail', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: fSizes.spaceBtwItems),

          // Container for Product Thumbnail
          fRoundedContainer(
            height: 300,
            backgroundColor: fColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thumbnail Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Obx(
                          () => fRoundedImage(
                            width: 220,padding: 0,
                            height: 220,
                            image: controller.selectedThumbnailImageUrl.value ?? fImages.Acer,
                            imageType: controller.selectedThumbnailImageUrl.value == null ? ImageType.asset : ImageType.network,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Add Thumbnail Button
                  SizedBox(
                    width: 200,
                    child: OutlinedButton(
                      onPressed: () => controller.selectThumbnailImage(),
                      child: const Text('Add Thumbnail'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
