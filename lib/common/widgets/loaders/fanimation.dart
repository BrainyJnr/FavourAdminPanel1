import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:flutter/material.dart';

class fLoaderAnimation extends StatelessWidget {
  const fLoaderAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        fImages.Animation1,
        height: 200,
        width: 200,
      ),
    );
  }
}
