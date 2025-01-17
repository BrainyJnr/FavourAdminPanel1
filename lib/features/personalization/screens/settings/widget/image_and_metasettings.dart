import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/uploader/image_uploader.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilis/constants/image_strings.dart';
import '../../../../../utilis/constants/sizes.dart';

class ImageAndMetaSettings extends StatelessWidget {
  const ImageAndMetaSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      padding: const EdgeInsets.symmetric(
        vertical: fSizes.lg,
        horizontal: fSizes.md,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // User Image
            const ImageUploader(
              imageType: ImageType.asset,
              right: 10,
              bottom: 20,
              left: null,
              width: 200,
              height: 200,
              circular: true,
              icon: Iconsax.camera,
              image: fImages.Profile1,
            ),
            const SizedBox(
              height: fSizes.spaceBtwItems,
            ),
            Text(
                "G-SERVANT",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            const SizedBox(
              height: fSizes.spaceBtwSections,
            ),
          ],
        ),
      ),
    );
  }
}
