import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../all_products/model/product_model.dart';
import '../../controller/product_images_controller.dart';
import '../../create_product/widgets/additional_images.dart';
import '../../create_product/widgets/thumbnail_widget.dart';
import '../widgets/attributes_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/brand_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/stock_pricing_widget.dart';
import '../widgets/title_description.dart';
import '../widgets/variations_widget.dart';
import '../widgets/visibility_widget.dart';

class EditProductMobileScreen extends StatelessWidget {
  const EditProductMobileScreen({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());

    return Scaffold(
      bottomNavigationBar: ProductBottomNavigationButtons(product: product),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const fBreadCrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Edit Product',
                breadcrumbItems: [fRoutes.products, 'Edit Product'],
              ),
              const SizedBox(height: fSizes.spaceBtwSections),

              // Edit Product
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProductTitleAndDescription(),
                  const SizedBox(height: fSizes.spaceBtwSections),

                  // Stock & Pricing
                  fRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Heading
                        Text('Stock & Pricing', style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: fSizes.spaceBtwItems),

                        // Product Type
                        const ProductTypeWidget(),
                        const SizedBox(height: fSizes.spaceBtwInputFields),

                        // Stock
                        const ProductStockAndPricing(),
                        const SizedBox(height: fSizes.spaceBtwSections),

                        // Attributes
                        ProductAttributes(), // Edit/Delete Attributes
                        const SizedBox(height: fSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                  const SizedBox(height: fSizes.spaceBtwSections),

                  // Variations
                  const ProductVariations(), // Edit/Delete Variations
                  const SizedBox(height: fSizes.spaceBtwSections),

                  // Sidebar
                  const ProductThumbnailImage(),
                  const SizedBox(height: fSizes.spaceBtwSections),

                  // Product Images
                  fRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('All Product Images', style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: fSizes.spaceBtwItems),
                        ProductAdditionalImages(
                          additionalProductImagesURLs: controller.additionalProductImagesUrls,
                          onTapToAddImages: () => controller.selectMultipleProductImages(),
                          onTapToRemoveImage: (index) => controller.removeImage(index),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: fSizes.spaceBtwSections),

                  // Product Brand
                  const ProductBrand(),
                  const SizedBox(height: fSizes.spaceBtwSections),

                  // Product Categories
                  ProductCategories(product: product),
                  const SizedBox(height: fSizes.spaceBtwSections),

                  // Product Visibility
                  const ProductVisibilityWidget(),
                  const SizedBox(height: fSizes.spaceBtwSections),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
