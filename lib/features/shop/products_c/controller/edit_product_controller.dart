import 'package:favour_adminpanel/common/widgets/loaders/ffull_screenloader.dart';
import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/features/shop/products_c/controller/product_attributes_controller.dart';
import 'package:favour_adminpanel/features/shop/products_c/controller/product_controller.dart';
import 'package:favour_adminpanel/features/shop/products_c/controller/product_images_controller.dart';
import 'package:favour_adminpanel/features/shop/products_c/controller/product_variations_controller.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/manager/network_manager.dart';
import '../../../../utilis/constants/enums.dart';
import '../../../../utilis/constants/sizes.dart';
import '../../brands/model/brand_model.dart';
import '../../categories/model/category_model.dart';
import '../../controller/category_controller.dart';
import '../all_products/model/product_category_model.dart';
import '../all_products/model/product_model.dart';
import '../repository/product_repository.dart';


class EditProductController extends GetxController {
  // Singleton instance
  static EditProductController get instance => Get.find();

  // Observables for loading state and product details
  final isLoading = false.obs;
  final selectedCategoriesLoader = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  // Controllers and keys
  final variationsController = Get.put(ProductVariationController());
  final attributesController = Get.put(ProductAttributesController());
  final imagesController = Get.put(ProductImagesController());
  final productRepository = Get.put(ProductRepository());
  final stockPriceFormKey = GlobalKey<FormState>();
  final titleDescriptionFormKey = GlobalKey<FormState>();

  // Text editing controllers for input fields
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // Rx observables for selected brand and categories
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final List<CategoryModel> alreadyAddedCategories = <CategoryModel>[];

  // Flags for tracking different tasks
  RxBool thumbnailUploader = true.obs;
  RxBool productDataUploader = false.obs;
  RxBool additionalImagesUploader = true.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  // Initialize Product Data
  void initProductData(ProductModel product) {
    try {
      isLoading.value = true; // Set loading state while initializing data

      // Basic Information
      title.text = product.title;
      description.text = product.description ?? '';
      productType.value = product.productType == ProductType.single.toString() ? ProductType.single : ProductType.variable;

      // Stock & Pricing (assuming productType and productVisibility are handled elsewhere)
      if (product.productType == ProductType.single.toString()) {
        stock.text = product.stock.toString();
        price.text = product.price.toString();
        salePrice.text = product.salePrice.toString();
      }

      // Product Brand
      selectedBrand.value = product.brand;
      brandTextField.text = product.brand?.name ?? '';

      // Product Thumbnail and Images
      if (product.images != null) {
        // Set the first image as the thumbnail
        imagesController.selectedThumbnailImageUrl.value = product.thumbnail;

        // Add the images to additionalProductImagesUrl
        imagesController.additionalProductImagesUrls.assignAll(product.images ?? []);
      }

      // Product Attributes & Variations (assuming you have a method to fetch variations in ProductVariationController)
      attributesController.productAttributes.assignAll(product.productAttributes ?? []);
      variationsController.productVariations.assignAll(product.productVariations ?? []);
      variationsController.initializeVariationControllers(product.productVariations ?? []);

      isLoading.value = false; // Set loading state back to false after initialization

      update();
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
    selectedCategoriesLoader.value = true;
    // Product Categories
    final productCategories = await productRepository.getProductCategories(productId);
    final categoriesController = Get.put(CategoryController());
    if (categoriesController.allItems.isEmpty) await categoriesController.fetchItems();

    final categoriesIds = productCategories.map((e) => e.categoryId).toList();
    final categories = categoriesController.allItems.where((element) => categoriesIds.contains(element.id)).toList();
    selectedCategories.assignAll(categories);
    alreadyAddedCategories.assignAll(categories);
    selectedCategoriesLoader.value = false;
    return categories;
  }

  // Function to create a new product
  Future<void> editProduct(ProductModel product) async {
    try {
      // Show progress dialog
      showProgressDialog();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        fFullScreenLoader.stopLoading();
        return;
      }

      // Validate title and description form
      if (!titleDescriptionFormKey.currentState!.validate()) {
        fFullScreenLoader.stopLoading();
        return;
      }

      // Validate stock and pricing form if ProductType = Single
      if (productType.value == ProductType.single && !stockPriceFormKey.currentState!.validate()) {
        fFullScreenLoader.stopLoading();
        return;
      }

      // Ensure a brand is selected
      if (selectedBrand.value == null) throw 'Select Brand for this product';

      // Check variation data if ProductType = Variable
      if (productType.value == ProductType.variable && ProductVariationController.instance.productVariations.isEmpty) {
        throw 'There are no variations for the Product Type Variable. Create some variations or change Product type.';
      }
      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariationController.instance.productVariations.any(
          (element) =>
              element.price.isNaN ||
              element.price < 0 ||
              element.salePrice.isNaN ||
              element.salePrice < 0 ||
              element.stock.isNaN ||
              element.stock < 0,
        );

        if (variationCheckFailed) throw 'Variation data is not accurate. Please recheck variations';
      }

      // Upload Product Thumbnail Image
      final imagesController = ProductImagesController.instance;
      if (imagesController.selectedThumbnailImageUrl.value == null || imagesController.selectedThumbnailImageUrl.value!.isEmpty) {
        throw 'Upload Product Thumbnail Image';
      }

      // Upload Product Variation Images if any
      var variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        // If admin added variations and then changed the Product Type, remove all variations
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }

      product.sku = '';
      product.isFeatured = true;
      product.title = title.text.trim();
      product.brand = selectedBrand.value;
      product.description = description.text.trim();
      product.productType = productType.value.toString();
      product.stock = int.tryParse(stock.text.trim()) ?? 0;
      product.price = double.tryParse(price.text.trim()) ?? 0;
      product.images = imagesController.additionalProductImagesUrls;
      product.salePrice = double.tryParse(salePrice.text.trim()) ?? 0;
      product.thumbnail = imagesController.selectedThumbnailImageUrl.value ?? '';
      product.productAttributes = ProductAttributesController.instance.productAttributes;
      product.productVariations = variations;

      // Call Repository to Update New Product
      productDataUploader.value = true;
      await ProductRepository.instance.updateProduct(product);

      // Register product categories if any
      if (selectedCategories.isNotEmpty) {
        // Loop through selected Product Categories
        categoriesRelationshipUploader.value = true;

        // Get the existing category IDs
        List<String> existingCategoryIds = alreadyAddedCategories.map((category) => category.id).toList();

        for (var category in selectedCategories) {
          // Check if the category is not already associated with the product
          if (!existingCategoryIds.contains(category.id)) {
            // Map Data
            final productCategory = ProductCategoryModel(productId: product.id, categoryId: category.id);
            await ProductRepository.instance.createProductCategory(productCategory);
          }
        }

        // Remove categories not selected by the user`
        for (var existingCategoryId in existingCategoryIds) {
          // Check if the category is not present in the selected categories
          if (!selectedCategories.any((category) => category.id == existingCategoryId)) {
            // Remove the association
            await ProductRepository.instance.removeProductCategory(product.id, existingCategoryId);
          }
        }
      }

      // Update Product List
      ProductController.instance.updateItemFromLists(product);

      // Reset Form Values
      // resetValues();

      // Close the Progress Loader
      fFullScreenLoader.stopLoading();

      // Show Success Message Loader
      showCompletionDialog();
    } catch (e) {
      fFullScreenLoader.stopLoading();
      fLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Reset form values and flags
  void resetValues() {
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    stockPriceFormKey.currentState?.reset();
    titleDescriptionFormKey.currentState?.reset();
    title.clear();
    description.clear();
    stock.clear();
    price.clear();
    salePrice.clear();
    brandTextField.clear();
    selectedBrand.value = null;
    selectedCategories.clear();
    ProductVariationController.instance.resetAllValues();
    ProductAttributesController.instance.resetProductAttributes();

    // Reset Upload Flags
    thumbnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDataUploader.value = false;
    categoriesRelationshipUploader.value = false;
  }

  // Show the progress dialog
  void showProgressDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Updating Product'),
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(fImages.Animation1, height: 200, width: 200),
                const SizedBox(height: fSizes.spaceBtwItems),
                buildCheckbox('Thumbnail Image', thumbnailUploader),
                buildCheckbox('Additional Images', additionalImagesUploader),
                buildCheckbox('Product Data, Attributes & Variations', productDataUploader),
                buildCheckbox('Product Categories', categoriesRelationshipUploader),
                const SizedBox(height: fSizes.spaceBtwItems),
                const Text('Sit Tight, Your product is uploading...'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build a checkbox widget
  Widget buildCheckbox(String label, RxBool value) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: value.value
              ? const Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Colors.blue)
              : const Icon(CupertinoIcons.checkmark_alt_circle),
        ),
        const SizedBox(width: fSizes.spaceBtwItems),
        Text(label),
      ],
    );
  }

  // Show completion dialog
  void showCompletionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Congratulations'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text('Go to Products'))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(fImages.Animation1, height: 200, width: 200),
            const SizedBox(height: fSizes.spaceBtwItems),
            Text('Congratulations', style: Theme.of(Get.context!).textTheme.headlineSmall),
            const SizedBox(height: fSizes.spaceBtwItems),
            const Text('Your Product has been Created'),
          ],
        ),
      ),
    );
  }
}
