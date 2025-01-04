import 'package:flutter/material.dart';
import '../../../utilis/constants/colors.dart';
import '../../../utilis/constants/sizes.dart';
import '../../../utilis/helpers/helper_function.dart';

class fCircularIcon extends StatelessWidget {
  const fCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = fSizes.lg,
    required this.icon,
    this.color,
    this.backgroungColor,
    this.onpressed,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroungColor;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroungColor !=null ? backgroungColor!
            :fHelperFunctions.isDarkMode(context)
            ?fColors.black.withOpacity(0.9)
            : fColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(onPressed: onpressed,icon:  Icon(icon, color: color,size: size,)),
    );
  }
}
