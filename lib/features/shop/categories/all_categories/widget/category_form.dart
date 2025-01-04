import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/uploader/image_uploader.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilis/constants/colors.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      width: 500,
      child: Form(
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
            onChanged: (newValue) {},
            items: [
              DropdownMenuItem(
                  value: "",
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Text("item.name")],
                  ))
            ],
          ),
          const SizedBox(
            height: fSizes.spaceBtwInputFields * 2,
          ),
          ImageUploader(
            width: 80,
            height: 80,
            image: fImages.DefaultImage,
            imageType: ImageType.asset,
            // onIconButtonPressed: () {},
          ),
          SizedBox(
            height: fSizes.spaceBtwInputFields,
          ),

          CheckboxMenuButton(
              value: true, onChanged: (value) {}, child: Text("Featured")),
          SizedBox(
            height: fSizes.spaceBtwInputFields * 2,
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {},
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
