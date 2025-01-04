import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:flutter/material.dart';

import '../responsive_screen/desktop_banner_screen.dart';
import '../responsive_screen/mobile_banner_screen.dart';
import '../responsive_screen/tablet_banner_screen.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const fSiteTemplate(desktop: DesktopBannerScreen(),tablet: TabletBannerScreen(),mobile: MobileBannerScreen(),);
  }
}
