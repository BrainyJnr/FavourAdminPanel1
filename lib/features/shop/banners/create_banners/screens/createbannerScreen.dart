import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/shop/banners/create_banners/responsive/create_banner_tablet.dart';
import 'package:flutter/material.dart';

import '../responsive/create_banner_desktop.dart';
import '../responsive/create_banner_mobile.dart';

class Createbannerscreen extends StatelessWidget {
  const Createbannerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return fSiteTemplate(desktop: CreateBannerDesktop(),tablet: CreateBannerTablet(),mobile: CreateBannerMobile(),);
  }
}
