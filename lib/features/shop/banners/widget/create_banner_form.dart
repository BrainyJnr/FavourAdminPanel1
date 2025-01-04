import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:flutter/material.dart';
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
    return fRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(fSizes.defaultSpace),
      child: Form(
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
            GestureDetector(
              child: fRoundedImage(
                padding: fSizes.chi,
                width: 400,
                imageType: ImageType.asset,
                height: 200,
                backgroundColor: fColors.primaryBackground,
                image: fImages.DefaultImage,
              ),
            ),
            const SizedBox(
              height: fSizes.spaceBtwItems,
            ),
            TextButton(onPressed: () {}, child: Text("Select Image")),
          ],
        ),
        const SizedBox(
          height: fSizes.spaceBtwInputFields,
        ),
        Text(
          "Make your Banner Active or InActive",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        CheckboxMenuButton(
            value: true, onChanged: (value) {}, child: const Text("Active")),
        const SizedBox(
          height: fSizes.spaceBtwInputFields,
        ),

        // Dropdown Menu Screens
        DropdownButton<String>(
          value: 'search',
          onChanged: (String? newValue) {},
          items: [
            DropdownMenuItem<String>(
              value: 'home',
              child: Text('Home'),
            ),
            DropdownMenuItem<String>(
              value: 'search',
              child: Text('Search'),
            ),
          ],
        ),
        const SizedBox(
          height: fSizes.spaceBtwInputFields * 2,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: () {}, child: Text("Create")),
        ),
        const SizedBox(
          height: fSizes.spaceBtwInputFields * 2,
        )
      ])),
    );
  }
}
