import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features_authentication/screens/forget_password/responsive_screen/forget_password_desktop.dart';
import 'package:favour_adminpanel/features_authentication/screens/forget_password/responsive_screen/forget_password_mobile.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return fSiteTemplate(useLayout: false,desktop: ForgetPasswordDesktopTablet(),mobile: ForgetPasswordMobile(),);
  }
}
