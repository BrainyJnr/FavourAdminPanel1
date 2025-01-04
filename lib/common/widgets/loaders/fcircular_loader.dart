import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../utilis/constants/colors.dart';

class fCircularLoadeer extends StatelessWidget {
  final Color? foregroundColor;
  final Color? backgroundColor;
  const fCircularLoadeer({super.key,this.foregroundColor = fColors.white,this.backgroundColor = fColors.primary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(fSizes.lg),
      decoration: BoxDecoration(color: backgroundColor,shape: BoxShape.circle),
      child: Center(
        child: CircularProgressIndicator(color: foregroundColor,backgroundColor: Colors.transparent,),
      ),
    );
  }
}
