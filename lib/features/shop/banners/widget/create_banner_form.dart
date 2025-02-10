import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/data/repositories/banner/banner_repository.dart';
import 'package:favour_adminpanel/features/shop/banners/controller/banner_controller.dart';
import 'package:favour_adminpanel/features/shop/banners/controller/create_banner_controller.dart';
import 'package:favour_adminpanel/routes/all_appScreens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/styles/frounded_container.dart';
import '../../../../common/widgets/chips/choice_chip.dart';
import '../../../../common/widgets/uploader/image_uploader.dart';
import '../../../../utilis/constants/colors.dart';
import '../../../../utilis/constants/enums.dart';
import '../../../../utilis/constants/image_strings.dart';
import '../../../../utilis/constants/sizes.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());
    final controllers = Get.put(BannerRepository());
    final controller2 = Get.put(BannerController());
    return fRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(fSizes.defaultSpace),
      child: Form(
          key: controller.formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Heading
            const SizedBox(
              height: fSizes.sm,
            ),
            Text(
              "Create New Banner ",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: fSizes.spaceBtwSections,
            ),

            // Image Uploader & Featured Checkbox
            Column(
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: fRoundedImage(
                      padding: fSizes.chi,
                      width: 400,
                      image: controller.imageURL.value.isNotEmpty
                          ? controller.imageURL.value
                          : fImages.DefaultImage,
                      height: 200,
                      backgroundColor: fColors.primaryBackground,
                      imageType: controller.imageURL.value.isNotEmpty
                          ? ImageType.network
                          : ImageType.asset,
                    ),
                  ),
                ),
                const SizedBox(
                  height: fSizes.spaceBtwItems,
                ),
                TextButton(
                    onPressed: () => controller.pickImage(),
                    child: Text("Select Image")),
              ],
            ),
            const SizedBox(
              height: fSizes.spaceBtwInputFields,
            ),
            Text(
              "Make your Banner Active or InActive",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Obx(
              () => CheckboxMenuButton(
                  value: controller.isActive.value,
                  onChanged: (value) =>
                      controller.isActive.value = value ?? false,
                  child: const Text("Active")),
            ),
            const SizedBox(
              height: fSizes.spaceBtwInputFields,
            ),

            // Dropdown Menu Screens
            Obx(() {
              return DropdownButton<String>(
                value: controller.targetScreen.value,
                onChanged: (String? newValue) =>
                    controller.targetScreen.value = newValue!,
                items: AllAppScreens.AllAppScreenItems.map<
                    DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            }),
            const SizedBox(
              height: fSizes.spaceBtwInputFields * 2,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.createBanner(),
                  child: Text("Create")),
            ),
            const SizedBox(
              height: fSizes.spaceBtwInputFields * 2,
            )
          ])),
    );
  }
}
