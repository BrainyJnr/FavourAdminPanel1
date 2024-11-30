import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features_authentication/screens/login/responsive_screens/login_desktop_tablet.dart';
import 'package:favour_adminpanel/features_authentication/screens/login/responsive_screens/login_mobile.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return fSiteTemplate(
      useLayout: false,
      desktop: LoginDesktopTablet(),
      mobile: LoginMobile(),

    );
  }
}
