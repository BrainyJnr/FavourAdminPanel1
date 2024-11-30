import 'package:flutter/material.dart';
import '../../../../common/widgets/layouts/templates/login_Template.dart';
import '../widgets/head_form.dart';

class ForgetPasswordDesktopTablet extends StatelessWidget {
  const ForgetPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return fLoginTemplate(
        child: fHeaderandForm());
    ;
  }
}

