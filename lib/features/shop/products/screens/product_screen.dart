import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:flutter/material.dart';

import '../all_products/responsive_screens/productdesktopscreen.dart';
import '../all_products/responsive_screens/productmobilescreen.dart';
import '../all_products/responsive_screens/producttabletscreen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const fSiteTemplate(desktop: ProductDesktopScreen(),tablet: ProductTabletScreen(),mobile: ProductMobileScreen(),);
  }
}
