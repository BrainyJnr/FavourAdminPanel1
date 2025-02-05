import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/common/widgets/shimmers/shimmer.dart';
import 'package:favour_adminpanel/common/widgets/uploader/image_uploader.dart';
import 'package:favour_adminpanel/features/shop/controller/category_controller.dart';
import 'package:favour_adminpanel/features/shop/controller/create_category_controller.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilis/constants/colors.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateCategoryController());
    final categoryController = Get.put(CategoryController());
    return fRoundedContainer(
      width: 500,
      child: Form(
        key: createController.formKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: fSizes.sm,
          ),
          Text(
            "Create New Category",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: fSizes.spaceBtwSections,
          ),

          // Name Text Field
          TextFormField(
            controller: createController.name,
            validator: (value) => fValidator.validateEmptyText("Name", value),
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black12, // Border color when enabled
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  // Border when not focused
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black12, // Border color when enabled
                    width: 1.5,
                  ),
                ),
                labelText: "Category Name",
                prefixIcon: const Icon(Iconsax.category)),
          ),
          SizedBox(
            height: fSizes.spaceBtwInputFields * 2,
          ),

          // Categories Dropdown
          Obx(
            () => categoryController.isLoading.value ?
            const fShimmerEffect(width: double.infinity, height: 55)
            :
            DropdownButtonFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black12, // Border color when enabled
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Border when not focused
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black12, // Border color when enabled
                      width: 1.5,
                    ),
                  ),
                  hintText: "Parent Category",
                  labelText: "Parent Category",
                  prefixIcon: Icon(Iconsax.bezier)),
              onChanged: (newValue) => createController.selectParent.value = newValue!,
              items: categoryController.allItems.map((item) =>
                DropdownMenuItem(
                    value: item,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Text(item.name)]),
                    )
            ).toList(),
            ),
          ),


          const SizedBox(
            height: fSizes.spaceBtwInputFields * 2,
          ),
          Obx(
            () =>  ImageUploader(
              width: 80,
              height: 80,
              image: createController.imageURL.value.isNotEmpty ? createController.imageURL.value : fImages.DefaultImage,
              imageType: createController.imageURL.value.isNotEmpty ? ImageType.network : ImageType.asset,
              onIconButtonPressed: () => createController.pickImage(),
            ),
          ),
          SizedBox(
            height: fSizes.spaceBtwInputFields,
          ),

          Obx(
            () => CheckboxMenuButton(
                value: createController.isFeatured.value,
                onChanged: (value) => createController.isFeatured.value = value ?? false,
                child: Text("Featured")),
          ),
          SizedBox(
            height: fSizes.spaceBtwInputFields * 2,
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => createController.createCategory(),
                  child: Text(
                    "Create",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.white),
                      backgroundColor: fColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))))),

          SizedBox(
            height: fSizes.spaceBtwInputFields * 2,
          ),
        ],
      )),
    );
  }
}
