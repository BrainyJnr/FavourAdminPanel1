import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/create_product_desktop.dart';
import 'responsive_screens/create_product_mobile.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const fSiteTemplate(desktop: CreateProductDesktopScreen(), mobile: CreateProductMobileScreen());
  }
}
