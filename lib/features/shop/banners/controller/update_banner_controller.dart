import 'package:favour_adminpanel/common/widgets/loaders/ffull_screenloader.dart';
import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/common/widgets/manager/network_manager.dart';
import 'package:favour_adminpanel/data/repositories/banner/banner_repository.dart';
import 'package:favour_adminpanel/features/shop/banners/controller/banner_controller.dart';
import 'package:favour_adminpanel/features/shop/banners/model/banner_model.dart';
import 'package:favour_adminpanel/features/shop/dashboard/widget/orderstatus_piechart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../routes/all_appScreens.dart';
import '../../../media/controller/media_controller.dart';
import '../../../media/model/image_model.dart';


class UpdateBannerController extends GetxController {
  static UpdateBannerController get instance => Get.find();


  final loading = false.obs;
  final isActive = false.obs;
  final imageURL = "".obs;
  final targetScreen = "".obs;
  final isFeatured = false.obs;
  final repository = Get.put(BannerRepository());
  final formKey = GlobalKey<FormState>();

  /// Init Data
  void init(BannerModel banner) {
    imageURL.value = banner.imageUrl ?? "";
    isActive.value = banner.active ?? false;
    targetScreen.value = banner.targetScreen.isNotEmpty ? banner.targetScreen : AllAppScreens.dashboard;
  }


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

  Future<void> updateBanner(BannerModel banner) async {
    try {
      fFullScreenLoader.PopUpCircular();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        fFullScreenLoader.stopLoading();
        return;
      }

      if (!formKey.currentState!.validate()) {
        fFullScreenLoader.stopLoading();
        return;
      }

      if (imageURL.value.isEmpty || targetScreen.value.isEmpty) {
        fFullScreenLoader.stopLoading();
        fLoaders.errorSnackBar(title: "Error", message: "Please select an image and target screen.");
        return;
      }

      if (banner.imageUrl != imageURL.value ||
          banner.targetScreen != targetScreen.value ||
          banner.active != isActive.value) {
        banner.imageUrl = imageURL.value;
        banner.targetScreen = targetScreen.value;
        banner.active = isActive.value;

        await repository.UpdateBanner(banner);
      }

      BannerController.instance.updateItemFromLists(banner);

      fFullScreenLoader.stopLoading();
      fLoaders.successSnackBar(title: "Success", message: "Banner updated successfully");
    } catch (e) {
      fFullScreenLoader.stopLoading();
      fLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }
  }
