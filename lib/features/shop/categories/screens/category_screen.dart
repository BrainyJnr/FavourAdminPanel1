import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:flutter/material.dart';

import '../all_categories/responsive_screen/category_desktopscreen.dart';
import '../all_categories/responsive_screen/category_tabletscreen.dart';
import '../all_categories/responsive_screen/mobile_categoryscreen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return fSiteTemplate(desktop: CategoryDesktopscreen(),tablet: CategoryTabletscreen(),mobile: MobileCategoryscreen(),);
  }
}
