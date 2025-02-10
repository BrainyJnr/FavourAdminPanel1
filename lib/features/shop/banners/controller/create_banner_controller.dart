import 'package:favour_adminpanel/common/widgets/loaders/ffull_screenloader.dart';
import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/common/widgets/manager/network_manager.dart';
import 'package:favour_adminpanel/data/repositories/banner/banner_repository.dart';
import 'package:favour_adminpanel/features/media/controller/media_controller.dart';
import 'package:favour_adminpanel/features/media/model/image_model.dart';
import 'package:favour_adminpanel/features/shop/banners/controller/banner_controller.dart';
import 'package:favour_adminpanel/features/shop/banners/model/banner_model.dart';
import 'package:favour_adminpanel/features/shop/categories/model/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../routes/all_appScreens.dart';

class CreateBannerController extends GetxController {
  static CreateBannerController get instance => Get.find();

  final selectParent = CategoryModel
      .empty()
      .obs;
  final loading = false.obs;
  final isActive = false.obs;
  final RxString targetScreen = AllAppScreens.AllAppScreenItems[0].toString().obs;
  RxString imageURL = "".obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller
        .selectedImageFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      // Update the main using the selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  /// Register new Banner
  Future<void> createBanner() async {
    try {
      fFullScreenLoader.PopUpCircular();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        fFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        fFullScreenLoader.stopLoading();
        return;
      }

      // Map Data
      final newRecord = BannerModel(
          id: "",
          imageUrl: imageURL.value,
          targetScreen: targetScreen.value,
          active: isActive.value);

      newRecord.id = await BannerRepository.instance.CreateBanner(newRecord);

      BannerController.instance.addItemToLists(newRecord);

      fFullScreenLoader.stopLoading();

      fLoaders.successSnackBar(title: "Congratulations", message: "New Record has been added");
    } catch (e) {
      fFullScreenLoader.stopLoading();
      fLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}


