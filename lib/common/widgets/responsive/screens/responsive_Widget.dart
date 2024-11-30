import 'package:flutter/material.dart';

import '../../../../utilis/constants/sizes.dart';

class fResponsiveWidget extends StatelessWidget {
  final Widget desktop;
  final Widget tablet;
  final Widget mobile;

  const fResponsiveWidget({
    super.key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth >= fSizes.desktopScreenSize) {
          return desktop; // Render desktop layout
        } else if (constraints.maxWidth >= fSizes.tabletScreenSize) {
          return tablet; // Render tablet layout
        } else {
          return mobile; // Render mobile layout
        }
      },
    );
  }
}
