import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/personalization/screens/settings/responsive_screens/settings_desktop_screen.dart';
import 'package:favour_adminpanel/features/personalization/screens/settings/responsive_screens/settings_mobile_screen.dart';
import 'package:favour_adminpanel/features/personalization/screens/settings/responsive_screens/settings_tablet_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return fSiteTemplate(desktop: SettingsDesktopScreen(),tablet: SettingsTabletScreen(),mobile: SettingsMobileScreen(),);
  }
}
