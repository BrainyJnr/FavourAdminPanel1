import 'package:favour_adminpanel/features_authentication/screens/reset_password/responsive_screens/reset_password_desktop.dart';
import 'package:favour_adminpanel/features_authentication/screens/reset_password/responsive_screens/reset_password_mobile.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/layouts/templates/side_layout.dart';


class ResetPasssword extends StatelessWidget {
  const ResetPasssword({super.key});

  @override
  Widget build(BuildContext context) {
    return fSiteTemplate(useLayout: false,desktop: ResetPasswordDesktop(),mobile: ResetPasswordMobile(),);
  }
}
