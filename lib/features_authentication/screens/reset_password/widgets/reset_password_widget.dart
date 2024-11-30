import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../common/widgets/texts/text_strings.dart';
import '../../../../routes/routes.dart';
import '../../../../utilis/constants/colors.dart';
import '../../../../utilis/constants/image_strings.dart';
import '../../../../utilis/constants/sizes.dart';

class fResetPasswordWidget extends StatelessWidget {
  const fResetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';
    return Column(
      children: [
        ///Header
        IconButton(
            onPressed: () => Get.offAllNamed(fRoutes.login),
            icon: Icon(CupertinoIcons.clear)),
        const SizedBox(
          height: fSizes.spaceBtwItems,
        ),

        ///Image
        const Image(
          image: AssetImage("assets/images/animation/Password.jpg"),
          width: 300,
          height: 300,
        ),

        ///Title & SubTitle
        Text(
          fTexts.changeYourPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: fSizes.spaceBtwItems,
        ),
        Text(
          email,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(
          height: fSizes.spaceBtwItems,
        ),
        Text(
          fTexts.changeYourPasswordSubTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: fSizes.spaceBtwSections,
        ),
        const SizedBox(
          height: fSizes.spaceBtwSections,
        ),

        ///Buttons
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                  backgroundColor: fColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {},
              child: const Text(
                fTexts.done,
                style: TextStyle(color: fColors.white),
              )),
        ),
        const SizedBox(
          height: fSizes.spaceBtwItems,
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
              onPressed: () {}, child: const Text(fTexts.resendEmail)),
        )
      ],
    );
  }
}
