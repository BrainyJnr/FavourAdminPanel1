import 'package:favour_adminpanel/common/widgets/layouts/templates/login_Template.dart';
import 'package:flutter/material.dart';
import '../../../widget/login_form.dart';
import '../../../widget/login_header.dart';

class LoginDesktopTablet extends StatelessWidget {
  const LoginDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const fLoginTemplate(
      child: Column(
        children: [
          //Header
          fLoginHeader(),

          // Form
          fLoginForm()
        ],
      ),
    );
  }
}
