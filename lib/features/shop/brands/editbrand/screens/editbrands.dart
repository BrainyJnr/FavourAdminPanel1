import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/shop/brands/model/brand_model.dart';
import 'package:flutter/material.dart';

import '../responsive/editBrandDesktopScreen.dart';
import '../responsive/editBrandMobileScreen.dart';
import '../responsive/editBrandTabletScreen.dart';

class Editbrands extends StatelessWidget {
  const Editbrands({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = BrandModel(id: "", name: "", image: "",);
    return fSiteTemplate(
      desktop: EditBrandDesktopScreen(brand: brand,),
      tablet: EditBrandTabletScreen(brand: brand,),
      mobile: EditBrandMobileScreen(brand: brand,),
    );
  }
}
