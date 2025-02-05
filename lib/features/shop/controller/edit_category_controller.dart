import 'package:favour_adminpanel/common/widgets/loaders/ffull_screenloader.dart';
import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/common/widgets/manager/network_manager.dart';
import 'package:favour_adminpanel/data/repositories/category/category_repositories.dart';
import 'package:favour_adminpanel/features/media/controller/media_controller.dart';
import 'package:favour_adminpanel/features/media/model/image_model.dart';
import 'package:favour_adminpanel/features/shop/categories/model/category_model.dart';
import 'package:favour_adminpanel/features/shop/controller/category_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final selectParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = "".obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ///Init Data
  void init(CategoryModel category) {
    name.text = category.name;
    isFeatured.value = category.isFeatured;
    imageURL.value = category.image;
    if(category.parentId.isNotEmpty) {
      selectParent.value = CategoryController.instance.allItems.where((c) => c.id == category.parentId).single;
    }
  }
  ///Method ro reset fields


  ///Pick Thumbnail Image from Media


  ///Register new Category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      print("Starting category creation...");
      fFullScreenLoader.PopUpCircular();

      final isConnected = await NetworkManager.instance.isConnected();
      print("Network status: $isConnected");
      if (!isConnected) {
        fFullScreenLoader.stopLoading();
        print("No internet connection");
        return;
      }

      if (!formKey.currentState!.validate()) {
        fFullScreenLoader.stopLoading();
        print("Form validation failed");
        return;
      }

      //Map Data
      category.image = imageURL.value;
      category.name = name.text.trim();
      category.parentId = selectParent.value.id;
      category.isFeatured = isFeatured.value;
      category.updatedAt = DateTime.now();

      //Call Repository to Create New User
      await CategoryRepositories.instance.updateCategory(category);

      //Update All Data List
      CategoryController.instance.updateItemFromLists(category);

      //Reset Form
      resetFields();

      fFullScreenLoader.stopLoading();

      fLoaders.successSnackBar(
          title: "Congratulations", message: "Your Record has been updated");
    } catch (e) {
      fFullScreenLoader.stopLoading();
      fLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
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

  void resetFields() {
    selectParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = "";
  }
}