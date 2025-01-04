import 'package:favour_adminpanel/features/shop/brands/model/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/styles/frounded_container.dart';
import '../../../../common/widgets/chips/choice_chip.dart';
import '../../../../common/widgets/uploader/image_uploader.dart';
import '../../../../utilis/constants/colors.dart';
import '../../../../utilis/constants/enums.dart';
import '../../../../utilis/constants/image_strings.dart';
import '../../../../utilis/constants/sizes.dart';

class EditBrandForm extends StatelessWidget {
  const EditBrandForm ({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(fSizes.defaultSpace),
      child: Form(
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
                    ),                    labelText: "Brand Name", prefixIcon: Icon(Iconsax.box)),
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
              Wrap(
                spacing: fSizes.sm,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: fSizes.sm),
                    child: fChoiceChip(
                      text: "Shoes",
                      selected: true,
                      onSelected: (value) {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: fSizes.sm),
                    child: fChoiceChip(
                      text: "Track Suites",
                      selected: false,
                      onSelected: (value) {},
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: fSizes.spaceBtwInputFields * 2,
              ),

              // Image Uploader & Featured Checkbox
              ImageUploader(
                imageType: ImageType.asset,
                width: 80,
                height: 80,
                image: fImages.Acer,
                onIconButtonPressed: () {},
              ),
              const SizedBox(
                height: fSizes.spaceBtwInputFields,
              ),

              // Checkbox
              CheckboxMenuButton(
                  value: true, onChanged: (value) {}, child: Text("Featured")),
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
                    onPressed: () {},
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
