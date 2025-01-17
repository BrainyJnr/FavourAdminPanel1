import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/personalization/screens/profile/responsive_screens/profile_desktop_screen.dart';
import 'package:favour_adminpanel/features/personalization/screens/profile/responsive_screens/profile_mobile_screen.dart';
import 'package:favour_adminpanel/features/personalization/screens/profile/responsive_screens/profile_tablet_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return fSiteTemplate(desktop: ProfileDesktopScreen(),tablet: ProfileTabletScreen(),mobile: ProfileMobileScreen(),);
  }
}
