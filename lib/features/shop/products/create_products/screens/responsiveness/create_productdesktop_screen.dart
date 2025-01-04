import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/product_additional_images.dart';
import '../../widgets/product_attributes.dart';
import '../../widgets/product_bottom_navigationButtons.dart';
import '../../widgets/product_brand.dart';
import '../../widgets/product_categories.dart';
import '../../widgets/product_thumbnailimage.dart';
import '../../widgets/product_variations.dart';
import '../../widgets/product_visibility_widget.dart';
import '../../widgets/productstockandpricing.dart';
import '../../widgets/producttypewidget.dart';
import '../../widgets/title_description.dart';

class CreateProductdesktopScreen extends StatelessWidget {
  const CreateProductdesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ProductBottomNavigationbuttons(),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //BreadCrumbs
              fBreadCrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: "Create Product",
                  breadcrumbItems: [fRoutes.products, "Create Product"]),
              const SizedBox(height: fSizes.spaceBtwSections,),

              // Create Product
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: fDeviceUtilis.isTabletScreen(context) ? 2 : 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Basic Information
                          ProductTitleAndDescription(),
                          const SizedBox(height: fSizes.spaceBtwSections,),

                          // Stock & Pricing
                          fRoundedContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Heading
                                Text("Stock & Pricing", style: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall,),
                                SizedBox(height: fSizes.spaceBtwItems,),

                                // Product Type
                                ProductTypeWidget(),
                                const SizedBox(
                                  height: fSizes.spaceBtwInputFields,),

                                // Stock
                                ProductStockAndPricing(),
                                SizedBox(height: fSizes.spaceBtwSections,),

                                // Attribute
                                ProductAttributes(),
                                SizedBox(height: fSizes.spaceBtwSections,)

                              ],
                            ),
                          ),
                          SizedBox(height: fSizes.spaceBtwSections,),

                          // Variations
                          const ProductVariations(),

                        ],
                      )),
                  const SizedBox(width: fSizes.defaultSpace,),

                  // sidebar
                  Expanded(child: Column(
                    children: [
                      ProductThumbnailImage(),
                      SizedBox(height: fSizes.spaceBtwSections,),

                      // Product Image
                      fRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("All Product Images", style: Theme
                                .of(context)
                                .textTheme
                                .headlineSmall,),
                            SizedBox(height: fSizes.spaceBtwItems,),
                            ProductAdditionalImages(
                                additionalProductImageURLS: RxList<
                                    String>.empty(),
                                onTapToAddImages: () {},
                                onTapToRemoveImages: (index) {}
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: fSizes.spaceBtwSections,),


                      // Product Brand
                      const ProductBrand(),
                      const SizedBox(height: fSizes.spaceBtwSections,),

                      // Product Categories
                      const ProductCategories(),
                      const SizedBox(height: fSizes.spaceBtwSections,),

                      // Product Visibility
                      const ProductVisibilityWidget(),
                      const SizedBox(height: fSizes.spaceBtwSections,),


                    ],
                  ))
                ],
              )
            ],
          ),),
      ),
    );
  }
}
