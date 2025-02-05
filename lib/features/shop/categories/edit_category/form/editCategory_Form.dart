import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/features/shop/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/uploader/image_uploader.dart';
import '../../../../../utilis/constants/colors.dart';
import '../../../../../utilis/constants/enums.dart';
import '../../../../../utilis/constants/image_strings.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../../../../utilis/validators/fvalidators.dart';
import '../../../controller/edit_category_controller.dart';
import '../../model/category_model.dart';
import 'package:get/get.dart';

class EditcategoryForm extends StatelessWidget {
  const EditcategoryForm({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditCategoryController());
    editController.init(category);
    final categoryController = Get.put(CategoryController());
    return fRoundedContainer(
      width: 500,
      child: Form(
          key: editController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: fSizes.sm,
              ),
              Text(
                "Update Category",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: fSizes.spaceBtwSections,
              ),

              // Name Text Field
              TextFormField(
                controller: editController.name,
                validator: (value) =>
                    fValidator.validateEmptyText("Name", value),
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

              Obx(
                () => DropdownButtonFormField(
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black12,
                            // Border color when enabled
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          // Border when not focused
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black12,
                            // Border color when enabled
                            width: 1.5,
                          ),
                        ),
                        hintText: "Parent Category",
                        labelText: "Parent Category",
                        prefixIcon: Icon(Iconsax.bezier)),
                    value: editController.selectParent.value.id.isNotEmpty
                        ? editController.selectParent.value
                        : null,
                    onChanged: (newValue) =>
                        editController.selectParent.value = newValue!,
                    items: categoryController.allItems
                        .map((item) => DropdownMenuItem(
                            value: item,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [Text(item.name)],
                            )))
                        .toList()),
              ),
              const SizedBox(
                height: fSizes.spaceBtwInputFields * 2,
              ),
              ImageUploader(
                width: 80,
                height: 80,
                image: editController.imageURL.value.isNotEmpty
                    ? editController.imageURL.value
                    : fImages.DefaultImage,
                imageType: editController.imageURL.value.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
                onIconButtonPressed: () => editController.pickImage(),
              ),
              SizedBox(
                height: fSizes.spaceBtwInputFields,
              ),

              Obx(
                () => CheckboxMenuButton(
                    value: editController.isFeatured.value,
                    onChanged: (value) =>
                        editController.isFeatured.value = value ?? false,
                    child: Text("Featured")),
              ),
              SizedBox(
                height: fSizes.spaceBtwInputFields * 2,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => editController.updateCategory(category),
                      child: Text(
                        "Update",
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
