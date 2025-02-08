import 'package:favour_adminpanel/common/widgets/loaders/ffull_screenloader.dart';
import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';

import 'package:favour_adminpanel/features/shop/brands/controller/brand_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../../../../common/widgets/manager/network_manager.dart';
import '../../../../data/repositories/brand/brand_repository.dart';
import '../../../media/controller/media_controller.dart';
import '../../../media/model/image_model.dart';
import '../../categories/model/category_model.dart';
import '../model/brand_category_model.dart';
import '../model/brand_model.dart';

class UpdateBrandController extends GetxController {
  static UpdateBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = "".obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BrandRepository());
  final List<CategoryModel> selectedCategory = <CategoryModel>[].obs;

  /// Init Data
  void init(BrandModel brand) {
    name.text = brand.name;
    imageURL.value = brand.image;
    isFeatured.value = brand.isFeatured;
    if(brand.brandCategories != null) {
      selectedCategory.addAll(brand.brandCategories ?? []);
    }
  }

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

  Future<void> UpdateBrand(BrandModel brand) async {
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
      // Form Validation
      if (!formKey.currentState!.validate()) {
        fFullScreenLoader.stopLoading();
        return;
      }

      // Is Data Updated
      bool isBrandUpdated = false;
      if (brand.image != imageURL.value || brand.name != name.text.trim() ||
          brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;

        // Map Data
        brand.image = imageURL.value;
        brand.name = name.text.trim();
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();

        // Call Repository to Update
        await repository.updateBrand(brand);
      }

      // Update BrandCategories
      if(selectedCategory.isNotEmpty) await updateBrandCategories(brand);

      // Update Brand Data in Products
      if(isBrandUpdated) await updateBrandInProducts(brand);

      // Update All Data List
      BrandController.instance.updateItemFromLists(brand);

      // Update UI Listeners
      update();

      // Remove Loader
      fFullScreenLoader.stopLoading();

      // Success Message & Redirect
      fLoaders.successSnackBar(title: "Congratulations", message: "Your Record has been Updated");
    } catch (e) {
      fFullScreenLoader.stopLoading();
      fLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }


  /// Update Categories of this Brand
  updateBrandCategories(BrandModel brand) async {
    // Fetch all BrandCategories
    final brandCategories = await repository.getCategoriesOfSpecificBrand(
        brand.id);

    // SelectCategories
    final selectCategoryIds = selectedCategory.map((e) => e.id);

    final categoriesToRemove =
    brandCategories.where((existingCategory) =>
    !selectCategoryIds.contains(existingCategory.categoryId)).toList();

    // Remove unselected categories
    for (var categoryToRemove in categoriesToRemove) {
      await BrandRepository.instance.deleteBrandCategory(
          categoryToRemove.id ?? "");
    }

    final newCategoryToAdd = selectedCategory.where((newCategory) =>
    !brandCategories.any((existingCategory) =>
    existingCategory.categoryId == newCategory.id))
        .toList();

    // Add new categories
    for (var newCategory in newCategoryToAdd) {
      var brandCategory = BrandCategoryModel(
          brandId: brand.id, categoryId: newCategory.id);
      brandCategory.id =
      await BrandRepository.instance.createBrandCategory(brandCategory);
    }

    brand.brandCategories!.assignAll(selectedCategory);
    BrandController.instance.updateItemFromLists(brand);
  }

  /// Update Products of this Brand
  updateBrandInProducts(BrandModel brand) async {

  }

}
