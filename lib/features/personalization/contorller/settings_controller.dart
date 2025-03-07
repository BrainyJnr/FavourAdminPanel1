import 'package:favour_adminpanel/common/widgets/loaders/ffull_screenloader.dart';
import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/common/widgets/manager/network_manager.dart';
import 'package:favour_adminpanel/features/media/controller/media_controller.dart';
import 'package:favour_adminpanel/features/media/model/image_model.dart';
import 'package:favour_adminpanel/features/personalization/model/settings_model.dart';
import 'package:favour_adminpanel/features/personalization/repositories/settings_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  // Observable Variables
  RxBool loading = false.obs;
  Rx<SettingsModel> settings = SettingsModel().obs;

  final formkey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final taxController = TextEditingController();
  final shippingController = TextEditingController();
  final freeShippingThresholdController = TextEditingController();

  // Dependencies
  final settingRepository = Get.put(SettingsRepository());

  @override
  void onInit() {
    fetchSettingsDetails();
    super.onInit();
  }

  Future<SettingsModel> fetchSettingsDetails() async {
    try {
      loading.value = true;
      final settings = await settingRepository.getSettings();
      this.settings.value = settings;

      appNameController.text = settings.appName;
      taxController.text = settings.taxRate.toString();
      shippingController.text = settings.shippingCost.toString();
      freeShippingThresholdController.text =
          settings.freeShippingThreshold == null
              ? ""
              : settings.freeShippingThreshold.toString();

      loading.value = false;

      return settings;
    } catch (e) {
      fLoaders.errorSnackBar(
          title: "Something went wrong", message: e.toString());
      return SettingsModel();
    }
  }

  /// Pick Thumbnail Image from Media
  void updateAppLogo() async {
    try {
      loading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectImages =
          await controller.selectedImageFromMedia();

      // Handle the selected Images
      if (selectImages != null && selectImages.isNotEmpty) {
        // Get the selected image to the main image or perform any other action
        ImageModel selectImage = selectImages.first;

        // Update Profile in Firestore
        await settingRepository.updateSingleField({"appLogo": selectImage.url});

        // Update the main image using the selectedImage
        settings.value.appLogo = selectImage.url;
        settings.refresh();

        fLoaders.successSnackBar(
            title: "Congratulations", message: "App Logo has been Updated");
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      fLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  void updateSettingsInformation() async {
    try {
      loading.value = true;

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        fFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formkey.currentState!.validate()) {
        fFullScreenLoader.stopLoading();
        return;
      }

      settings.value.appName = appNameController.text.trim();
      settings.value.taxRate =
          double.tryParse(taxController.text.trim()) ?? 0.0;
      settings.value.shippingCost =
          double.tryParse(shippingController.text.trim()) ?? 0.0;
      settings.value.freeShippingThreshold =
          double.tryParse(freeShippingThresholdController.text.trim()) ?? 0.0;

      await settingRepository.updateSettingDetails(settings.value);
      settings.refresh();

      loading.value = false;
      fLoaders.successSnackBar(
          title: "Congratulations", message: "App Settings has been Updated");
    } catch (e) {
      loading.value = false;
      fLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
