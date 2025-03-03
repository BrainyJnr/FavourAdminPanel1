import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/common/widgets/uploader/image_uploader.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utilis/constants/enums.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../all_products/model/product_variation_model.dart';
import '../../controller/edit_product_controller.dart';
import '../../controller/product_images_controller.dart';
import '../../controller/product_variations_controller.dart';



class ProductVariations extends StatelessWidget {
  const ProductVariations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final variationController = ProductVariationController.instance;

    return Obx(
      () => EditProductController.instance.productType.value == ProductType.variable
          ? fRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Variations Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Product Variations', style: Theme.of(context).textTheme.headlineSmall),
                      TextButton(
                        onPressed: () => variationController.removeVariations(context),
                        child: const Text('Remove Variations'),
                      ),
                    ],
                  ),
                  const SizedBox(height: fSizes.spaceBtwItems),

                  // Variations List
                  if (variationController.productVariations.isNotEmpty)
                    ListView.separated(
                      itemCount: variationController.productVariations.length,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => const SizedBox(height: fSizes.spaceBtwItems),
                      itemBuilder: (_, index) {
                        final variation = variationController.productVariations[index];
                        return _buildVariationTile(context, index, variation, variationController);
                      },
                    )
                  else
                    _buildNoVariationsMessage(),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  // Helper method to build a variation tile
  Widget _buildVariationTile(
      BuildContext context, int index, ProductVariationModel variation, ProductVariationController variationController) {
    return ExpansionTile(
      backgroundColor: fColors.lightGrey,
      collapsedBackgroundColor: fColors.lightGrey,
      childrenPadding: const EdgeInsets.all(fSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(fSizes.borderRadiusLg)),
      title: Text(variation.attributeValues.entries.map((entry) => '${entry.key}: ${entry.value}').join(', ')),
      children: [
        // Upload Variation Image
        Obx(
          () => ImageUploader(
            right: 0,
            left: null,
            circular: true,
            imageType: variation.image.value.isNotEmpty ? ImageType.network : ImageType.asset,
            image: variation.image.value.isNotEmpty ? variation.image.value : fImages.Acer,
            onIconButtonPressed: () => ProductImagesController.instance.selectVariationImage(variation),
          ),
        ),
        const SizedBox(height: fSizes.spaceBtwInputFields),

        // Variation Stock, and Pricing
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => variation.stock = int.parse(value),
                decoration: const InputDecoration(labelText: 'Stock', hintText: '0'),
                controller: variationController.stockControllersList[index][variation],
              ),
            ),
            const SizedBox(width: fSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => variation.price = double.parse(value),
                decoration: const InputDecoration(labelText: 'Price', hintText: '\$'),
                controller: variationController.priceControllersList[index][variation],
              ),
            ),
            const SizedBox(width: fSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => variation.salePrice = double.parse(value),
                controller: variationController.salePriceControllersList[index][variation],
                decoration: const InputDecoration(labelText: 'Discounted Price', hintText: '\$'),
              ),
            ),
          ],
        ),
        const SizedBox(height: fSizes.spaceBtwInputFields),

        // Variation Description
        TextFormField(
          onChanged: (value) => variation.description = value,
          controller: variationController.descriptionControllersList[index][variation],
          decoration: const InputDecoration(labelText: 'Description', hintText: 'Add description of this variation...'),
        ),
        const SizedBox(height: fSizes.spaceBtwSections),
      ],
    );
  }

  // Helper method to build message when there are no variations
  Widget _buildNoVariationsMessage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            fRoundedImage(
                padding: 0,
                width: 200, height: 200, imageType: ImageType.asset, image: fImages.Acer),
          ],
        ),
        const SizedBox(height: fSizes.spaceBtwItems),
        const Text('There are no Variations added for this product'),
      ],
    );
  }
}
