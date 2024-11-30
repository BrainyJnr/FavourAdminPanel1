import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:favour_adminpanel/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import '../../utilis/constants/colors.dart';
import '../../utilis/constants/enums.dart';
import '../../utilis/constants/sizes.dart';

class fRoundedImage extends StatelessWidget {
  const fRoundedImage({
    super.key,

    this.height = 56,
    this.image,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = fColors.light,
    this.fit = BoxFit.contain,
    required this.padding,
    this.margin,
    // this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = fSizes.md,
    this.width = 56,
    this.file, this.imageType,
    this.overlayColor, this.memoryImage,

  });

  final double width, height, padding;
  final bool applyImageRadius;
  final File? file;
  final String? image;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;

  //final EdgeInsetsGeometry? padding;
  // final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final double? margin;
  final ImageType? imageType;
  final Uint8List? memoryImage;
  final Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    return
      //GestureDetector(
      // onTap: onPressed,
      Container(
        width: width,
        height: height,
        margin: margin != null ? EdgeInsets.all(margin!) : null,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          border: border, color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: _buildImageWidget(),
      );
  }

  Widget _buildImageWidget() {
     Widget imageWidget;

    switch (imageType) {
      case ImageType.network:
        imageWidget = _buildNetworkImage();
        break;
      case ImageType.memory:
        imageWidget = _buildMemoryImage();
        break;
      case ImageType.file:
        imageWidget = _buildFileImage();
        break;
      case ImageType.asset:
        imageWidget = _buildAssetImage();
        break;
      default:
        imageWidget = const SizedBox(); // Provide a default value.
    }

    return ClipRRect(
      borderRadius: applyImageRadius
          ? BorderRadius.circular(borderRadius)
          : BorderRadius.zero,
      child: imageWidget,
    );
  }


  /// Function to build the network Image Widget
  Widget _buildNetworkImage() {
    if (image != null) {
      return CachedNetworkImage(
        fit: fit,
        color: overlayColor,
        imageUrl: image!,
        errorWidget: (context, url, error) => Icon(Icons.error),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            fShimmerEffect(width: width, height: height),);
    } else {
      return Container();
    }
  }

  Widget _buildMemoryImage() {
    if (image != null) {
      return Image(
        image: MemoryImage(memoryImage!), color: overlayColor, fit: fit,);
    } else {
      return Container();
    }
  }

  Widget _buildFileImage() {
    if (image != null) {
      return Image(
        image: FileImage(file!), color: overlayColor, fit: fit,);
    } else {
      return Container();
    }
  }

  Widget _buildAssetImage() {
    if (image != null) {
      return Image(
        image: AssetImage(image!), color: overlayColor, fit: fit,);
    } else {
      return Container();
    }
  }


}
