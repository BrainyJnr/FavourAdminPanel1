import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/uploader/image_uploader.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilis/constants/image_strings.dart';
import '../../../../../utilis/constants/sizes.dart';

class ImageAndMeta extends StatelessWidget {
  const ImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
          vertical: fSizes.lg, horizontal: fSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // User Image
              ClipRect(
                child: const ImageUploader(
                  imageType: ImageType.asset,
                  right: 10,
                  bottom: 20,
                  //left: null,
                  width: 200,
                  height: 200,
                  circular: true,
                  icon: Iconsax.camera,
                  image: fImages.Puma,
                ),
              ),
              const SizedBox(
                height: fSizes.spaceBtwItems,
              ),
              Text(
                "Godwin Chimdike",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Text("godwinchimdikefavour@gmail.com"),
              const SizedBox(
                height: fSizes.spaceBtwSections,
              ),
            ],
          )
        ],
      ),
    );
  }
}
