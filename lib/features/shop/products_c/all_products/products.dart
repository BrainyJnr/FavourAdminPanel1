import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:flutter/material.dart';
import 'responsive_screens/products_desktop.dart';
import 'responsive_screens/products_mobile.dart';
import 'responsive_screens/products_tablet.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const fSiteTemplate(desktop: ProductsDesktopScreen(), tablet: ProductsTabletScreen(), mobile: ProductsMobileScreen());
  }
}
