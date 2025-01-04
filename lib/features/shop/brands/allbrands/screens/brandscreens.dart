import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:flutter/material.dart';

import '../responsive_screens/brandsDesktopScreen.dart';
import '../responsive_screens/brandsMobileScreen.dart';
import '../responsive_screens/brandsTabletScreen.dart';

class Brandscreens extends StatelessWidget {
  const Brandscreens({super.key});

  @override
  Widget build(BuildContext context) {
    return fSiteTemplate(desktop: BrandsDesktopScreen(),tablet: BrandsTabletScreen(),mobile: BrandsMobileScreen(),);
  }
}
