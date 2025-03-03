import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/styles/frounded_container.dart';
import '../../../../../common/widgets/uploader/image_uploader.dart';
import '../../../../../utilis/constants/colors.dart';
import '../../../../../utilis/constants/enums.dart';
import '../../../../../utilis/constants/image_strings.dart';
import '../../../../../utilis/constants/sizes.dart';


class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({super.key, required this.additionalProductImagesURLs, this.onTapToAddImages, this.onTapToRemoveImage});

  final RxList<String> additionalProductImagesURLs;
  final void Function()? onTapToAddImages;
  final void Function(int index)? onTapToRemoveImage;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 300,
        child: Column(
          children: [
            // Section to Add Additional Product Images
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: onTapToAddImages,
                child: fRoundedContainer(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(fImages.Acer, width: 50, height: 50),
                        const Text('Add Additional Product Images'),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Section to Display Uploaded Images
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 2, child: SizedBox(height: 80, child: _uploadedImagesOrEmptyList())),
                  const SizedBox(width: fSizes.spaceBtwItems / 2),

                  // Add More Images Button
                  fRoundedContainer(
                    width: 80,
                    height: 80,
                    showBorder: true,
                    borderColor: fColors.grey,
                    backgroundColor: fColors.white,
                    onTap: onTapToAddImages,
                    child: const Center(child: Icon(Iconsax.add)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to Display Either Uploaded Images or Empty List
  Widget _uploadedImagesOrEmptyList() {
    return additionalProductImagesURLs.isNotEmpty ? _uploadedImages() : emptyList();
  }

  // Widget to Display Empty List Placeholder
  Widget emptyList() {
    return ListView.separated(
      itemCount: 6,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(width: fSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) => const fRoundedContainer(backgroundColor: fColors.primaryBackground, width: 80, height: 80),
    );
  }

  // Widget to Display Uploaded Images
  ListView _uploadedImages() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: additionalProductImagesURLs.length,
      separatorBuilder: (context, index) => const SizedBox(width: fSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) {
        final image = additionalProductImagesURLs[index];
        return ImageUploader(
          top: 0,
          right: 0,
          width: 80,
          height: 80,
          left: null,
          bottom: null,
          image: image,
          icon: Iconsax.trash,
          imageType: ImageType.network,
          onIconButtonPressed: () => onTapToRemoveImage!(index),
        );
      },
    );
  }
}
