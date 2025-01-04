import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/uploader/image_uploader.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilis/constants/sizes.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages(
      {super.key,
      required this.additionalProductImageURLS,
      this.onTapToAddImages,
      this.onTapToRemoveImages});

  final RxList<String> additionalProductImageURLS;
  final void Function()? onTapToAddImages;
  final void Function(int index)? onTapToRemoveImages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          // Section to add Additional Product Images
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: onTapToAddImages,
                child: fRoundedContainer(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          fImages.Acer,
                          width: 50,
                          height: 50,
                        ),
                        const Text("Add Additional Product Images")
                      ],
                    ),
                  ),
                ),
              )),

          // Section to Display Uploaded Images
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child:
                      SizedBox(height: 80, child: _uploadedImageOrEmptyList())),
              const SizedBox(
                width: fSizes.spaceBtwItems / 2,
              ),

              // Add More Images Button
              fRoundedContainer(
                width: 80,
                height: 80,
                showBorder: true,
                borderColor: fColors.white,
                onTap: onTapToAddImages,
                child: Center(
                  child: Icon(Iconsax.add),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  // Widget to Display Either Uploaded Images or Empty List
  Widget _uploadedImageOrEmptyList() {
    return emptyList();
  }

  // Widget to Display Empty List Placeholder
  Widget emptyList() {
    return ListView.separated(
        itemBuilder: (context, index) => fRoundedContainer(
              backgroundColor: fColors.primaryBackground,
              width: 80,
              height: 80,
            ),
        separatorBuilder: (context, index) => fRoundedContainer(
              backgroundColor: fColors.primaryBackground,
              width: 80,
              height: 80,
            ),
        itemCount: 6);
  }

  // Widget to Display Uploaded Images
  ListView _uploadedImages() {
    return ListView.separated(
        itemCount: additionalProductImageURLS.length,
        separatorBuilder: (context, index) => SizedBox(
              width: fSizes.spaceBtwItems / 2,
            ),
        itemBuilder: (context, index) {
          final image = additionalProductImageURLS[index];
          return ImageUploader(
            top: null,
            right: 0,
            width: 80,
            height: 80,
            left: 0,
            bottom: null,
            image: image,
            imageType: ImageType.asset,
            icon: Iconsax.trash,
            onIconButtonPressed: () => onTapToRemoveImages!(index),
          );
        });
  }
}
