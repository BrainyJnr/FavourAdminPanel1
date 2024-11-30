import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utilis/constants/enums.dart';
import '../../utilis/constants/sizes.dart';
import '../widgets/shimmers/shimmer.dart';

class fCircular_Images extends StatelessWidget {
  const fCircular_Images({
    super.key,

    this.fit = BoxFit.cover,
    this.image,
    this.overlayColor,
    this.memoryImage,
    this.backgroundColor,
    this.file,
    this.width = 56,
    this.imageType = ImageType.asset,
    AssetImage = false,
    this.height = 56,
    this.padding = fSizes.sm


  });

  final BoxFit? fit;
  final String? image;
  final File? file;
  final ImageType? imageType;
  final Uint8List? memoryImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding:  EdgeInsets.all(padding),
        decoration: BoxDecoration(
        color: backgroundColor ?? (Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white),
            borderRadius: BorderRadius.circular(1)
        ),
        child: _buildImageWidget()
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
      borderRadius:
      BorderRadius.circular(width >= height ? width : height),
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
            fShimmerEffect(width: 50, height: 50),);
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
