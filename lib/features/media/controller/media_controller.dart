import 'dart:typed_data';
import 'package:favour_adminpanel/common/widgets/loaders/ffull_screenloader.dart';
import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/common/widgets/texts/text_strings.dart';
import 'package:favour_adminpanel/features/media/model/image_model.dart';
import 'package:favour_adminpanel/features/media/repository/media_repositroy.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'dart:html' as html; // For web
import 'package:universal_html/html.dart' as html;

import '../../../common/widgets/dialog/fdialog.dart';
import '../../../utilis/constants/sizes.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  final RxBool loading = false.obs;

  final int initialLoadCount = 20;
  final int loadMoreCount = 25;

  late DropzoneViewController dropzoneController;
  final RxBool showImagesUploadSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;
  final MediaRepository mediaRepository = MediaRepository();


  // Get Images
  void getMediaImages() async {
    try{
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if(selectedPath.value == MediaCategory.banners && allBannerImages.isEmpty){
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.Brands && allBannerImages.isEmpty){
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.category && allBannerImages.isEmpty){
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.Products && allBannerImages.isEmpty){
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.Users && allBannerImages.isEmpty){
        targetList = allUserImages;
      }

      final images = await mediaRepository.fetchImagesDatabase(selectedPath.value, initialLoadCount);
      targetList.assignAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      fLoaders.errorSnackBar(title: "Oh Snap", message:  "Unable to fetch Images, Something went wrong. Try again");
    }
  }

  loadMoreMediaImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if(selectedPath.value == MediaCategory.banners){
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.Brands && allBannerImages.isEmpty){
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.category && allBannerImages.isEmpty){
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.Products && allBannerImages.isEmpty){
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.Users && allBannerImages.isEmpty){
        targetList = allUserImages;
      }
      final images = await mediaRepository.loadMoreImageFromDatabase(selectedPath.value, initialLoadCount, targetList.last.createdAt
      ?? DateTime.now());
      targetList.addAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      fLoaders.errorSnackBar(title: "Oh Snap", message:  "Unable to fetch Images, Something went wrong. Try again");

    }
  }
  /// Select images locally via file picker
  Future<void> selectLocalImages() async {
    final files = await dropzoneController.pickFiles(
      multiple: true,
      mime: ['image/jpeg', 'image/png'], // Ensure correct MIME types
    );

    if (files.isNotEmpty) {
      for (var file in files) {
        final bytes = await dropzoneController.getFileData(file);
        final image = ImageModel(
          url: '',
          file: file,
          folder: '',
          filename: file.name,
          localImageToDisplay: Uint8List.fromList(bytes),
        );
        selectImagesToUpload.add(image);
        print("Image added: ${image.filename}");
      }
    } else {
      print('No files selected.');
    }
  }

  /// Handle drop zone file upload
  Future<void> onDropFile(DropzoneFileInterface file) async {
    final bytes = await dropzoneController.getFileData(file);
    final image = ImageModel(
      url: '',
      file: file,
      folder: '',
      filename: file.name,
      localImageToDisplay: Uint8List.fromList(bytes),
    );
    selectImagesToUpload.add(image);
    print("Dropped file added: ${image.filename}");
  }

  /// Upload selected images together
  void uploadImageConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      fLoaders.warningSnackBar(
          title: "Select Folder",
          message: "Please select the Folder in Order to upload the Images");
      return;
    }

    fDialogs.defaultDialog(
        context: Get.context!,
        title: "Upload Images",
        confirmText: "Upload",
        onConfirm: () async => await uploadImages(),
        content:
            "Are you sure you want to upload all the all the Images in ${selectedPath.value.name.toUpperCase()} folder?");
  }

  uploadImages() async {
    try {
      //remove confirmation box
      Get.back();

      //loader
      uploadImagesLoader();

      //get the selected category
      MediaCategory selectedCategory = selectedPath.value;

      //get the corresponding list to update
      RxList<ImageModel> targetList;

      //check the selected category and update the corresponding list
      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.Brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.category:
          targetList = allCategoryImages;
          break;
        case MediaCategory.Products:
          targetList = allProductImages;
          break;
        case MediaCategory.Users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      //upload and add images to the target list
      //using a reverse loop to avoid 'Concurrent modification during iteration' error
      for (int i = selectImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectImagesToUpload[i];
        final DropzoneFileInterface imageFile = selectedImage.file!;

        // Convert DropzoneFileInterface to Uint8List
        final Uint8List fileData = await dropzoneController.getFileData(imageFile);

        // Upload image to the storage
        final ImageModel uploadedImage = await mediaRepository.uploadImageFileInStorage(
          file: fileData, // Pass the Uint8List file data
          path: getSelectedPath(),
          imageName: selectedImage.filename,
        );

        // Upload metadata to FireStore
        uploadedImage.mediaCategory = selectedCategory.name;
        final id = await mediaRepository.uploadImageFileInDatabase(uploadedImage);

        uploadedImage.id = id;

        selectImagesToUpload.removeAt(i);
        targetList.add(uploadedImage);
      }

      // Stop Loader after successful upload
      fFullScreenLoader.stopLoading();
    } catch (e) {
      //stop loader in case of an error
      fFullScreenLoader.stopLoading();

      //show a warning snack-bar for the error
      fLoaders.warningSnackBar(
          title: "Error Uploading Images",
          message: "Something went wrong while uploading your images");
    }
  }

  void uploadImagesLoader() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text("Uploading Images"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    fImages.Animation1,
                    height: 300,
                    width: 300,
                  ),
                  const SizedBox(
                    height: fSizes.spaceBtwItems,
                  ),
                  const Text("Sit Tight, Your Images are Uploading...")
                ],
              ),
            )));
  }

  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = fTexts.bannerStoragePath;
        break;
      case MediaCategory.Brands:
        path = fTexts.brandsStoragePath;
        break;
      case MediaCategory.category:
        path = fTexts.categoriesStoragePath;
        break;
      case MediaCategory.Products:
        path = fTexts.productStoragePath;
        break;
      case MediaCategory.Users:
        path = fTexts.UsersStoragePath;
        break;
      default:
        path = 'Others';
        break;
    }
    return path; // Explicitly return the path
  }
}
