import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/shop/banners/edit_banners/responsive_screens/edit_banner_desktop.dart';
import 'package:favour_adminpanel/features/shop/banners/edit_banners/responsive_screens/edit_banner_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../responsive_screens/edit_banner_mobile.dart';

class EditBannerScreens extends StatelessWidget {
  const EditBannerScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
    return fSiteTemplate(
      desktop: EditBannerDesktop(banner: banner,),
      tablet: EditBannerTablet(banner: banner,),
      mobile: EditBannerMobile(banner: banner,),

    );
  }
}
