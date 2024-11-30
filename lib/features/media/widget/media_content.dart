import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/loaders/fAnimationLoaderWidget.dart';
import 'package:favour_adminpanel/common/widgets/loaders/fanimation.dart';
import 'package:favour_adminpanel/features/media/controller/media_controller.dart';
import 'package:favour_adminpanel/features/media/model/image_model.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import '../../../common/styles/frounded_image.dart';
import '../../../utilis/constants/colors.dart';
import '../../../utilis/constants/enums.dart';
import '../../../utilis/constants/image_strings.dart';
import '../responsive_media/view_image_detail.dart';
import 'folder_dropdown.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return fRoundedContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        /// Media Images Header
        Row(children: [
          Text(
            "Select Folder",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            width: fSizes.spaceBtwItems,
          ),
          MediaFolderDropdown(
            onChanged: (MediaCategory? newValue) {
              if (newValue != null) {
                controller.selectedPath.value = newValue;
                controller.getMediaImages();
              }
            },
          ),
        ]),

        SizedBox(
          height: fSizes.spaceBtwSections,
        ),

        /// Show Media
        Obx(() {
          List<ImageModel> images = _getSelectFolderImages(controller);

          // Loader
          if (controller.loading.value && images.isEmpty)
            return const fLoaderAnimation();

          // Empty Widget
          if (images.isEmpty) return _buildEmptyAnimationWidget(context);

          return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                    alignment: WrapAlignment.start,
                    spacing: fSizes.spaceBtwItems / 2,
                    runSpacing: fSizes.spaceBtwItems / 2,
                    children: images
                        .map((image) => GestureDetector(
                              onTap: () => Get.dialog(ImagePopUp(image: image,)),
                              child: SizedBox(
                                width: 140,
                                height: 180,
                                child: Column(
                                  children: [
                                    _buildSimpleList(image),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: fSizes.sm),
                                      child: Text(
                                        image.filename,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ))
                        .toList()),

                /// Load More Media Button
                if (!controller.loading.value)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: fSizes.spaceBtwSections),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: fSizes.buttonWidth,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: fColors.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () => controller.loadMoreMediaImages,
                            label: Text(
                              "Load More",
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: Icon(
                              Iconsax.arrow_down,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ]);
        })
      ]),
    );
  }
}

List<ImageModel> _getSelectFolderImages(MediaController controller) {
  List<ImageModel> images = [];

  if (controller.selectedPath.value == MediaCategory.banners) {
    images = controller.allBannerImages
        .where((image) => image.url.isNotEmpty)
        .toList();
  } else if (controller.selectedPath.value == MediaCategory.Brands) {
    images = controller.allBrandImages
        .where((image) => image.url.isNotEmpty)
        .toList();
  } else if (controller.selectedPath.value == MediaCategory.category) {
    images = controller.allCategoryImages
        .where((image) => image.url.isNotEmpty)
        .toList();
  } else if (controller.selectedPath.value == MediaCategory.Products) {
    images = controller.allProductImages
        .where((image) => image.url.isNotEmpty)
        .toList();
  } else if (controller.selectedPath.value == MediaCategory.Users) {
    images = controller.allUserImages
        .where((image) => image.url.isNotEmpty)
        .toList();
  }
  return images;
}

Widget _buildEmptyAnimationWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: fSizes.lg * 3),
    child: fAnimationLoaderWidget(
      width: 300,
      height: 300,
      text: "Select your Desired Folder",
      image: fImages.Animation1,
    ),
  );
}

Widget _buildSimpleList(ImageModel image) {
  return fRoundedImage(
    width: 140,
    height: 140,
    padding: fSizes.sm,
    image: image.url,
    imageType: ImageType.network,
    margin: fSizes.spaceBtwItems / 2,
    backgroundColor: fColors.primaryBackground,
  );
}
