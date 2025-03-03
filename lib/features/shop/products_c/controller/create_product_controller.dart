import 'package:favour_adminpanel/common/widgets/loaders/ffull_screenloader.dart';
import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/features/shop/products_c/controller/product_attributes_controller.dart';
import 'package:favour_adminpanel/features/shop/products_c/controller/product_controller.dart';
import 'package:favour_adminpanel/features/shop/products_c/controller/product_images_controller.dart';
import 'package:favour_adminpanel/features/shop/products_c/controller/product_variations_controller.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/manager/network_manager.dart';
import '../../../../utilis/constants/enums.dart';
import '../../../../utilis/constants/sizes.dart';
import '../../brands/model/brand_model.dart';
import '../../categories/model/category_model.dart';
import '../all_products/model/product_category_model.dart';
import '../all_products/model/product_model.dart';
import '../repository/product_repository.dart';


class CreateProductController extends GetxController {
  // Singleton instance
  static CreateProductController get instance => Get.find();

  // Observables for loading state and product details
  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  // Controllers and keys
  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final titleDescriptionFormKey = GlobalKey<FormState>();

  // Text editing controllers for input fields
  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // Rx observables for selected brand and categories
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  // Flags for tracking different tasks
  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  // Function to create a new product
  Future<void> createProduct() async {
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
        final variationCheckFailed = ProductVariationController.instance.productVariations.any((element) =>
            element.price.isNaN ||
            element.price < 0 ||
            element.salePrice.isNaN ||
            element.salePrice < 0 ||
            element.stock.isNaN ||
            element.stock < 0 ||
            element.image.value.isEmpty);

        if (variationCheckFailed) throw 'Variation data is not accurate. Please recheck variations';
      }

      // Upload Product Thumbnail Image
      thumbnailUploader.value = true;
      final imagesController = ProductImagesController.instance;
      if (imagesController.selectedThumbnailImageUrl.value == null) throw 'Select Product Thumbnail Image';

      // Additional Product Images
      additionalImagesUploader.value = true;

      // Product Variation Images
      final variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        // If admin added variations and then changed the Product Type, remove all variations
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }

      // Map Product Data to ProductModel
      final newRecord = ProductModel(
        id: '',
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        brand: selectedBrand.value,
        productVariations: variations,
        description: description.text.trim(),
        productType: productType.value.toString(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0,
        images: imagesController.additionalProductImagesUrls,
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0,
        thumbnail: imagesController.selectedThumbnailImageUrl.value ?? '',
        productAttributes: ProductAttributesController.instance.productAttributes,
        date: DateTime.now(),
      );

      // Call Repository to Create New Product
      productDataUploader.value = true;
      newRecord.id = await ProductRepository.instance.createProduct(newRecord);

      // Register product categories if any
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw 'Error storing data. Try again';

        // Loop through selected Product Categories
        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          // Map Data
          final productCategory = ProductCategoryModel(productId: newRecord.id, categoryId: category.id);
          await ProductRepository.instance.createProductCategory(productCategory);
        }
      }

      // Update Product List
      ProductController.instance.addItemToLists(newRecord);

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
          title: const Text('Creating Product'),
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
