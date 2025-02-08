import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/features/shop/brands/controller/update_brand_controller.dart';
import 'package:favour_adminpanel/features/shop/brands/model/brand_model.dart';
import 'package:favour_adminpanel/features/shop/controller/category_controller.dart';
import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
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

class EditBrandForm extends StatelessWidget {
  const EditBrandForm({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateBrandController());
    controller.init(brand);
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
                "Update Brand",
                style: Theme.of(context).textTheme.headlineMedium,
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
                    prefixIcon: Icon(Iconsax.category)),
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
                    .map((element) =>
                    Padding(
                      padding: EdgeInsets.only(bottom: fSizes.sm),
                      child: fChoiceChip(
                        text: element.name,
                        selected: controller.selectedCategory.contains(element),
                        onSelected: (value) => controller.toggleSelection(element),
                      ),
                    )).toList()),
              ),
              const SizedBox(
                height: fSizes.spaceBtwInputFields * 2,
              ),

              // Image Uploader & Featured Checkbox
              Obx(
                () => ImageUploader(
                  image: controller.imageURL.value.isNotEmpty ? controller.imageURL.value : fImages.animalIcon,
                  width: 80,
                  height: 80,
                  imageType: controller.imageURL.value.isNotEmpty ? ImageType.network : ImageType.asset,
                  onIconButtonPressed: () => controller.pickImage(),
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
                    onPressed: () => controller.UpdateBrand(brand),
                    child: Text(
                      "Update",
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
