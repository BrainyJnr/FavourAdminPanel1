import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/texts/text_strings.dart';
import '../../../../routes/routes.dart';
import '../../../../utilis/constants/colors.dart';
import '../../../../utilis/constants/sizes.dart';

class fHeaderandForm extends StatelessWidget {
  const fHeaderandForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Header
        IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
        const SizedBox(
          height: fSizes.spaceBtwItems,
        ),
        Text(
          fTexts.forgetPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: fSizes.spaceBtwItems,
        ),
        Text(
          fTexts.forgetPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(
          height: fSizes.spaceBtwItems * 2,
        ),

        ///Form
        Form(
            child: TextFormField(
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
                suffixIcon: IconButton(
                    onPressed: () {}, icon: const Icon(Iconsax.eye_slash)),
                prefixIcon: Icon(Iconsax.password_check),
                labelText: fTexts.password,
              ),
            )),

        SizedBox(
          height: fSizes.spaceBtwSections,
        ),

        ///Submit Button
        SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: fColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => Get.toNamed(fRoutes.resetPassword,
                  parameters: {'email': 'some@gmail.com'}),
              child: const Text(
                fTexts.submit,
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
