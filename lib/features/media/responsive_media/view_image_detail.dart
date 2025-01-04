import 'package:clipboard/clipboard.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/features/media/controller/media_controller.dart';
import 'package:favour_adminpanel/features/media/model/image_model.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImagePopUp extends StatelessWidget {
  const ImagePopUp({super.key, required this.image});

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(fSizes.borderRadiusLg)),
        child: fRoundedContainer(
            width: fDeviceUtilis.isDesktopScreen(context)
                ? MediaQuery.of(context).size.width * 0.4
                : double.infinity,
            padding: const EdgeInsets.all(fSizes.spaceBtwItems),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Stack(
                    children: [
                      fRoundedContainer(
                        backgroundColor: fColors.primaryBackground,
                        child: fRoundedImage(
                          image: image.url,
                          applyImageRadius: true,
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: fDeviceUtilis.isDesktopScreen(context)
                              ? MediaQuery.of(context).size.width * 0.4
                              : double.infinity,
                          imageType: ImageType.network,
                          padding: fSizes.chi,
                        ),
                      ),
                      Positioned(
                          child: IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(Iconsax.close_circle)))
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: fSizes.spaceBtwItems,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Image Name",
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                    Expanded(
                        child: Text(
                      image.filename,
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Image URL",
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                    Expanded(
                        flex: 2,
                        child: Text(
                          image.url,
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              FlutterClipboard.copy(image.url).then((value) =>
                                  fLoaders.customToast(message: "URL copied!"));
                            },
                            child: Text("Copy URL")))
                  ],
                ),

                const SizedBox(
                  height: fSizes.spaceBtwSections,
                ),

                //Display a button to delete the image.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextButton(
                          onPressed: () => MediaController.instance
                              .removeCloudImageConfirmation(image),
                          child: const Text(
                            "Delete Image",
                            style: TextStyle(color: Colors.red),
                          )),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
