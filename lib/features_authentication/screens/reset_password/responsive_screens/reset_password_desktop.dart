import 'package:favour_adminpanel/common/widgets/layouts/templates/login_Template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/reset_password_widget.dart';

class ResetPasswordDesktop extends StatelessWidget {
  const ResetPasswordDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return fLoginTemplate(
        child: fResetPasswordWidget());
  }
}

