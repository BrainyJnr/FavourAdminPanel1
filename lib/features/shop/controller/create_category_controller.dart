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

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final selectParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = "".obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ///Method ro reset fields


  ///Pick Thumbnail Image from Media


  ///Register new Category
  Future<void> createCategory() async {
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

      print("Mapping new category data...");
      final newRecord = CategoryModel(
        id: "",
        name: name.text.trim(),
        image: imageURL.value,
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
        parentId: selectParent.value.id,
      );

      print("Creating category in repository...");
      newRecord.id = await CategoryRepositories.instance.createCategory(newRecord);
      print("Category created with ID: ${newRecord.id}");

      CategoryController.instance.addItemToLists(newRecord);
      resetFields();
      fFullScreenLoader.stopLoading();
      fLoaders.successSnackBar(
          title: "Congratulations", message: "Added Successfully");
    } catch (e) {
      fFullScreenLoader.stopLoading();
      fLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
      print("Error: $e");
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