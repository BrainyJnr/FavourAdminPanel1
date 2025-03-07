import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/data/repositories/user/user_repository.dart';
import 'package:favour_adminpanel/features_authentication/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/ffull_screenloader.dart';
import '../../common/widgets/manager/network_manager.dart';
import '../../features/media/controller/media_controller.dart';
import '../../features/media/model/image_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  /// Fetches user details from the repository
  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    } catch (e) {
      loading.value = false;
      fLoaders.errorSnackBar(
          title: "Something went wrong", message: e.toString());
      return UserModel.empty();
    }
  }

  /// Pick Thumbnail Image from Media
  void updateProfilePicture() async {
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
        await userRepository
            .updateSingleField({"ProfilePicture": selectImage.url});

        // Update the main image using the selectedImage
        user.value.profilePicture = selectImage.url;
        user.refresh();

        fLoaders.successSnackBar(
            title: "Congratulations",
            message: "Your Profile Picture has been Updated");
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      fLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  void updateUserInformation() async {
    try {
      loading.value = true;

      // Check Internet Connectivity
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

      user.value.firstName = firstNameController.text.trim();
      user.value.lastName =  lastNameController.text.trim();
      user.value.phoneNumber = phoneController.text.trim();

      await userRepository.updateUserDetails(user.value);
      user.refresh();

      loading.value = false;
      fLoaders.successSnackBar(
          title: "Congratulations", message: "Your Profile has been Updated");
    } catch (e) {
      loading.value = false;
      fLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

}
