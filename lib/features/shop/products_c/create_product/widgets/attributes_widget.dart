import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilis/constants/colors.dart';
import '../../../../../utilis/constants/enums.dart';
import '../../../../../utilis/constants/image_strings.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../controller/create_product_controller.dart';
import '../../controller/product_attributes_controller.dart';
import '../../controller/product_variations_controller.dart';


class ProductAttributes extends StatelessWidget {
  ProductAttributes({Key? key}) : super(key: key);

  // Controllers
  final attributeController = Get.put(ProductAttributesController());
  final variationController = Get.put(ProductVariationController());

  @override
  Widget build(BuildContext context) {
    final productController = CreateProductController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => productController.productType.value == ProductType.single
            ? const Divider(color: fColors.primaryBackground)
            : const SizedBox.shrink()),
        Obx(() => productController.productType.value == ProductType.single
            ? const SizedBox(height: fSizes.spaceBtwSections)
            : const SizedBox.shrink()),

        Text('Add Product Attributes', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: fSizes.spaceBtwItems),

        Form(
          key: attributeController.attributesFormKey,
          child: fDeviceUtilis.isDesktopScreen(context)
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildAttributeName(attributeController)),
              const SizedBox(width: fSizes.spaceBtwItems),
              Expanded(flex: 2, child: _buildAttributes(attributeController)),
              const SizedBox(width: fSizes.spaceBtwItems),
              _buildAddAttributeButton(attributeController),
            ],
          )
              : Column(
            children: [
              _buildAttributeName(attributeController),
              const SizedBox(height: fSizes.spaceBtwItems),
              _buildAttributes(attributeController),
              const SizedBox(height: fSizes.spaceBtwItems),
              _buildAddAttributeButton(attributeController),
            ],
          ),
        ),
        const SizedBox(height: fSizes.spaceBtwSections),

        Text('All Attributes', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: fSizes.spaceBtwItems),

        fRoundedContainer(
          backgroundColor: fColors.primaryBackground,
          child: Obx(
                () => attributeController.productAttributes.isNotEmpty
                ? ListView.separated(
              shrinkWrap: true,
              itemCount: attributeController.productAttributes.length,
              separatorBuilder: (_, __) => const SizedBox(height: fSizes.spaceBtwItems),
              itemBuilder: (_, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: fColors.white,
                    borderRadius: BorderRadius.circular(fSizes.borderRadiusLg),
                  ),
                  child: ListTile(
                    title: Text(attributeController.productAttributes[index].name ?? ''),
                    subtitle: Text(attributeController.productAttributes[index].values!.map((e) => e.trim()).toString()),
                    trailing: IconButton(
                      onPressed: () => attributeController.removeAttribute(index, context),
                      icon: const Icon(Iconsax.trash, color: fColors.error),
                    ),
                  ),
                );
              },
            )
                : const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    fRoundedImage(
                        padding: 0,
                        width: 150, height: 80, imageType: ImageType.asset, image: fImages.Acer),
                  ],
                ),
                SizedBox(height: fSizes.spaceBtwItems),
                Text('There are no attributes added for this product'),
              ],
            ),
          ),
        ),

        const SizedBox(height: fSizes.spaceBtwSections),

        Obx(() => productController.productType.value == ProductType.variable && variationController.productVariations.isEmpty
            ? Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              icon: const Icon(Iconsax.activity),
              label: const Text('Generate Variations'),
              onPressed: () => variationController.generateVariationsConfirmation(context),
            ),
          ),
        )
            : const SizedBox.shrink()),
      ],
    );
  }

  SizedBox _buildAddAttributeButton(ProductAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => controller.addNewAttribute(),
        icon: const Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
          foregroundColor: fColors.black,
          backgroundColor: fColors.secondary,
          side: const BorderSide(color: fColors.secondary),
        ),
        label: const Text('Add'),
      ),
    );
  }

  TextFormField _buildAttributeName(ProductAttributesController controller) {
    return TextFormField(
      controller: controller.attributeName,
      validator: (value) => fValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(labelText: 'Attribute Name', hintText: 'Colors, Sizes, Material'),
    );
  }

  SizedBox _buildAttributes(ProductAttributesController controller) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        controller: controller.attributes,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) => fValidator.validateEmptyText('Attributes Field', value),
        decoration: const InputDecoration(
          labelText: 'Attributes',
          hintText: 'Add attributes separated by |  Example: Green | Blue | Yellow',
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}