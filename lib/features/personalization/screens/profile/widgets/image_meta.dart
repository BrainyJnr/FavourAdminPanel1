import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/uploader/image_uploader.dart';
import 'package:favour_adminpanel/features_authentication/controllers/user_controller.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilis/constants/image_strings.dart';
import '../../../../../utilis/constants/sizes.dart';

class ImageAndMeta extends StatelessWidget {
  const ImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
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
                child: Obx(
                  () => ImageUploader(
                    imageType: controller.user.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                    right: 10,
                    bottom: 20,
                    //left: null,
                    width: 200,
                    height: 200,
                    loading: controller.loading.value,
                    onIconButtonPressed: () => controller.updateProfilePicture(),
                    circular: true,
                    icon: Iconsax.camera,
                    image: controller.user.value.profilePicture.isNotEmpty ? controller.user.value.profilePicture : fImages.Puma,
                  ),
                ),
              ),
              const SizedBox(
                height: fSizes.spaceBtwItems,
              ),
              Obx(()
                => Text(
                  controller.user.value.fullName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
               Text(controller.user.value.email),
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
