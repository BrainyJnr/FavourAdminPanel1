import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:flutter/material.dart';

import '../responsive/createBrandDesktopScreen.dart';
import '../responsive/createBrandMobileScreen.dart';
import '../responsive/createBrandTabletScreen.dart';

class CreateBrands extends StatelessWidget {
  const CreateBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return fSiteTemplate(
      desktop: CreateBrandDesktopScreen(),
      tablet: CreateBrandTabletScreen(),
      mobile: CreateBrandMobileScreen(),
    );
  }
}
