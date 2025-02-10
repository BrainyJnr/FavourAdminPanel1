import 'package:favour_adminpanel/features/shop/banners/model/banner_model.dart';
import 'package:favour_adminpanel/routes/all_appScreens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/styles/frounded_container.dart';
import '../../../../common/styles/frounded_image.dart';
import '../../../../utilis/constants/colors.dart';
import '../../../../utilis/constants/enums.dart';
import '../../../../utilis/constants/image_strings.dart';
import '../../../../utilis/constants/sizes.dart';
import '../controller/update_banner_controller.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateBannerController());
    controller.init(banner);
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
          "Update Banner ",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: fSizes.spaceBtwSections,
        ),

        // Image Uploader & Featured Checkbox
        Column(
          children: [
            Obx(
              () => fRoundedImage(
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
                  // Ensure the selected value is always valid
                  String selectedValue = AllAppScreens.AllAppScreenItems.contains(controller.targetScreen.value)
                      ? controller.targetScreen.value
                      : AllAppScreens.AllAppScreenItems.first;

                  return DropdownButton<String>(
                    value: selectedValue, // Use valid default value
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.targetScreen.value = newValue;
                      }
                    },
                    items: AllAppScreens.AllAppScreenItems
                        .map<DropdownMenuItem<String>>((value) {
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
          child: ElevatedButton(onPressed: () => controller.updateBanner(banner), child: Text("Update")),
        ),
        const SizedBox(
          height: fSizes.spaceBtwInputFields * 2,
        )
      ])),
    );
  }
}
