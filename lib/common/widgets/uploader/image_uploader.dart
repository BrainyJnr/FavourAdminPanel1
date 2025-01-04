import 'package:favour_adminpanel/common/styles/fcircular_image.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../icons/fcircular_icon.dart';

class ImageUploader extends StatelessWidget {
  const ImageUploader({
    super.key,
    this.circular = false,
    this.image,
    required this.imageType,
    this.onIconButtonPressed,
    this.width = 100,
    this.height = 100,
    this.memoryImage,
    this.icon = Iconsax.edit_2,
    this.bottom = 0, // Custom bottom padding (adjust as needed)
    this.top = 0, // Custom bottom padding (adjust as needed)
    this.left = 0.0,   // Custom left padding (adjust as needed)
    this.right = 0,   // Custom left padding (adjust as needed)
  });

  final bool circular;
  final String? image;
  final ImageType imageType;
  final double width;
  final double height;
  final Uint8List? memoryImage;
  final IconData icon;
  final double? bottom; // Bottom padding
  final double? top; // Bottom padding
  final double left;   // Left padding
  final double right;   // right padding
  final void Function()? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Display the image (circular or rounded)
        circular
            ? fCircular_Images(
          image: image,
          width: width,
          height: height,
          imageType: imageType,
          memoryImage: memoryImage,
          backgroundColor: fColors.primaryBackground,
        )
            : fRoundedImage(
          padding: fSizes.chi,
          image: image,
          width: width,
          height: height,
          imageType: imageType,
          memoryImage: memoryImage,
          backgroundColor: fColors.primaryBackground,
        ),
        // Icon positioned at the bottom-left corner
        Positioned(
          bottom: bottom, // Positioned at the bottom
          top: top, // Positioned at the bottom
          left: left,     // Positioned at the left
          child: fCircularIcon(
            icon: icon,
            size: fSizes.md,
            color: Colors.white,
            onpressed: onIconButtonPressed,
            backgroungColor: fColors.primary.withOpacity(0.7), // Adjusted background color
          ),
        ),
      ],
    );
  }
}
