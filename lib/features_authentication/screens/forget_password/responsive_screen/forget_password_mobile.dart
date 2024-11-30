import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/head_form.dart';

class ForgetPasswordMobile extends StatelessWidget {
  const ForgetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(fSizes.defaultSpace),
        child: fHeaderandForm(),
      ),
    );
  }
}
