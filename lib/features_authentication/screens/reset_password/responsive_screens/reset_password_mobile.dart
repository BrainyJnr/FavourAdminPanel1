import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../widgets/reset_password_widget.dart';

class ResetPasswordMobile extends StatelessWidget {
  const ResetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
        child: fResetPasswordWidget(),),
    );
  }
}
