import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/chips/choice_chip.dart';
import 'package:favour_adminpanel/common/widgets/uploader/image_uploader.dart';
import 'package:favour_adminpanel/features/shop/brands/controller/create_brand_controller.dart';
import 'package:favour_adminpanel/features/shop/controller/category_controller.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utilis/constants/colors.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBrandController());
    return fRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(fSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          const SizedBox(
            height: fSizes.sm,
          ),
          Text(
            "Create New Brand",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: fSizes.spaceBtwSections,
          ),

          // Name TextField
          TextFormField(
            controller: controller.name,
            validator: (value) => fValidator.validateEmptyText("Name", value),
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black12, // Border color when enabled
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  // Border when not focused
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black12, // Border color when enabled
                    width: 1.5,
                  ),
                ),
                labelText: "Brand Name",
                prefixIcon: Icon(Iconsax.box)),
          ),
          const SizedBox(
            height: fSizes.spaceBtwInputFields,
          ),

          // Categories
          Text(
            "Select Categories",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: fSizes.spaceBtwInputFields / 2,
          ),
          Obx(
            () => Wrap(
              spacing: fSizes.sm,
              children: CategoryController.instance.allItems
                .map((category) =>
                Padding(
                  padding: EdgeInsets.only(bottom: fSizes.sm),
                  child: fChoiceChip(
                    text: category.name,
                    selected: controller.selectedCategory.contains(category),
                    onSelected: (value) => controller.toggleSelection(category)),
                  ),
                ).toList())),

          const SizedBox(
            height: fSizes.spaceBtwInputFields * 2,
          ),

          // Image Uploader & Featured Checkbox
          Obx(
            () => ImageUploader(
              imageType: controller.imageURL.value.isNotEmpty ? ImageType.network : ImageType.asset,
              width: 80,
              height: 80,
              image: controller.imageURL.value.isNotEmpty ? controller.imageURL.value : fImages.Acer,
              onIconButtonPressed: ()  => controller.pickImage(),
            ),
          ),
          const SizedBox(
            height: fSizes.spaceBtwInputFields,
          ),

          // Checkbox
          Obx(
            () => CheckboxMenuButton(
                value: controller.isFeatured.value,
                onChanged: (value) => controller.isFeatured.value = value ?? false,
                child: Text("Featured")),
          ),
          const SizedBox(
            height: fSizes.spaceBtwInputFields * 2,
          ),

          // Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.white),
                    backgroundColor: fColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () => controller.createBrand(),
                child: Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          const SizedBox(
            height: fSizes.spaceBtwInputFields * 2,
          )
        ],
      )),
    );
  }
}
