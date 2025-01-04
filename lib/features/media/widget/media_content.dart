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
  final bool allowSelection;
  final bool allowMultipleSection;
  final List<String>? alreadySelectedUrls;
  final Function(List<ImageModel> selectedImages)? onImagesSelected;

  MediaContent({
    super.key,
    required this.allowSelection,
    required this.allowMultipleSection,
    this.alreadySelectedUrls,
    this.onImagesSelected,
  });

  final RxList<ImageModel> selectedImages = <ImageModel>[].obs;

  @override
  Widget build(BuildContext context) {
    bool loadPreviousSelection = false;
    final controller = MediaController.instance;
    return fRoundedContainer(
      backgroundColor: fColors.primaryBackground,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
        /// Media Images Header
        Row(
          children: [
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
            )
          ]),SizedBox(width: 12,),
            if (allowSelection) buildAddSelectedImagesButton(),
            SizedBox(
              height: fSizes.spaceBtwSections,
            ),

          ]  ),

        /// Show Media
        Obx(() {
          List<ImageModel> images = _getSelectFolderImages(controller);

          if(!loadPreviousSelection) {
            if (alreadySelectedUrls != null &&
                alreadySelectedUrls!.isNotEmpty) {
              final selectedUrlsSet = Set<String>.from(alreadySelectedUrls!);

              for (var image in images) {
                image.isSelected.value = selectedUrlsSet.contains(image.url);
                if (image.isSelected.value) {
                  selectedImages.add(image);
                }
              }
            } else {
              for (var image in images) {
                image.isSelected.value = false;
              }
            }
            loadPreviousSelection = true;
          }
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
                              onTap: () => Get.dialog(ImagePopUp(
                                image: image,
                              )),
                              child: SizedBox(
                                width: 140,
                                height: 180,
                                child: Column(
                                  children: [
                                    allowSelection
                                        ? _buildListWithCheckbox(image)
                                        : _buildSimpleList(
                                            image,
                                          ),
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
  Widget _buildListWithCheckbox(ImageModel image) {
    return Stack(
      children: [
        fRoundedImage(
          width: 140,
          height: 140,
          image: image.url,
          imageType: ImageType.network,
          margin: fSizes.spaceBtwItems / 2,
          backgroundColor: fColors.primaryBackground,
          padding: fSizes.sm,
        ),
        Positioned(
          top: fSizes.md,
          right: fSizes.md,
          child: Obx(() => Checkbox(
              value: image.isSelected.value,
              onChanged: (selected) {
                if (selected != null) {
                  image.isSelected.value = selected;
                  if (selected) {
                    if (!allowMultipleSection) {
                      // if multiple selection is not allowed, uncheck other checkboxes
                      for (var otherImage in selectedImages) {
                        if (otherImage != image) {
                          otherImage.isSelected.value = false;
                        }
                      }
                      selectedImages.clear();
                    }
                    selectedImages.add(image);
                  } else {
                    selectedImages.remove(image);
                  }
                }
              })),
        )
      ],
    );
  }

  Widget buildAddSelectedImagesButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Close Button
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.black),
                  backgroundColor: fColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              label: const Text(
                "Close",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => Get.back(),
              icon: const Icon(
                Iconsax.close_circle,
                color: Colors.black,
              )),
        ),
        const SizedBox(
          width: fSizes.spaceBtwItems,
        ),
        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                side: BorderSide(color: Colors.white),
                backgroundColor: fColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () => Get.back(result: selectedImages),
            label: const Text("Add", style: TextStyle(color: Colors.white)),
            icon: const Icon(
              Iconsax.image,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
