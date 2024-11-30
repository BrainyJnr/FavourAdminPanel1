import 'package:flutter/material.dart';
import '../../common/widgets/texts/text_strings.dart';
import '../../utilis/constants/image_strings.dart';
import '../../utilis/constants/sizes.dart';

class fLoginHeader extends StatelessWidget {
  const fLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(
            width: 100,
            height: 100,
            image: AssetImage(fImages.favour),
          ),
          const SizedBox(
            height: fSizes.spaceBtwSections,
          ),
          Text(
            fTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: fSizes.sm,
          ),
          Text(
            fTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
