import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/features/shop/brands/controller/brand_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/loaders/ffull_screenloader.dart';
import '../../../../common/widgets/manager/network_manager.dart';
import '../../../../data/repositories/brand/brand_repository.dart';
import '../../../media/controller/media_controller.dart';
import '../../../media/model/image_model.dart';
import '../../categories/model/category_model.dart';
import '../model/brand_category_model.dart';
import '../model/brand_model.dart';

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = "".obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategory = <CategoryModel>[].obs;

  /// Toggle Category Selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategory.contains(category)) {
      selectedCategory.remove(category);
    } else {
      selectedCategory.add(category);
    }
  }


  void resetFields() {
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = "";
    selectedCategory.clear();
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

  Future<void> createBrand() async {
    try {
      // Start Loading
      fFullScreenLoader.PopUpCircular();

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

      // Map Data
      final newRecord = BrandModel(
        id: "",
        image: imageURL.value,
        productsCount: 0,
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
        name: name.text.trim(),);

      // Call Repository to Create New Brand
      newRecord.id = await BrandRepository.instance.createBrand(newRecord);

      // Register brand category if any
      if(selectedCategory.isNotEmpty) {
        if(newRecord.id.isEmpty) throw "Error storing relational data. Try again";

        // Loop selected Brand Categories
        for(var category in selectedCategory) {
          // Map Data
          final brandCategory = BrandCategoryModel(brandId: newRecord.id, categoryId: category.id);
          await BrandRepository.instance.createBrandCategory(brandCategory);
        }

        newRecord.brandCategories ??= [];
        newRecord.brandCategories!.addAll(selectedCategory);
      }

      // Update All Data List
      BrandController.instance.addItemToLists(newRecord);

      // Reset Form
      resetFields();

      // Remove Loader
      fFullScreenLoader.stopLoading();

      // Success Message & Redirect
      fLoaders.successSnackBar(title: "Congratulations", message: "New Recoed has been added.");
    } catch (e)  {
      fFullScreenLoader.stopLoading();
      fLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}