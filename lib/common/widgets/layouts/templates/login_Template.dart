import 'package:favour_adminpanel/utilis/helpers/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../../utilis/constants/colors.dart';
import '../../../../utilis/constants/sizes.dart';
import '../../../styles/spacing_style.dart';

class fLoginTemplate extends StatelessWidget {
  const fLoginTemplate({super.key, required this.child});

  ///The Widget to be displayed inside the login template
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: 550,
            child: SingleChildScrollView(
                child: Container(
              padding: fSpacingStyle.paddingWithAppBarHeight,
              decoration: BoxDecoration(
                color: fHelperFunctions.isDarkMode(context)
                    ? fColors.black
                    : fColors.white,
                borderRadius: BorderRadius.circular(fSizes.cardRadiusLg),
              ),
              child: child,
            ))));
  }
}
