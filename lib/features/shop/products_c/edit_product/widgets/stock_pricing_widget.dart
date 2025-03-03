import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utilis/constants/enums.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../controller/edit_product_controller.dart';


class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;

    return Obx(
      () => controller.productType.value == ProductType.single
          ? Form(
              key: controller.stockPriceFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stock
                  FractionallySizedBox(
                    widthFactor: 0.45,
                    child: TextFormField(
                      controller: controller.stock,
                      decoration: const InputDecoration(labelText: 'Stock'),
                      validator: (value) => fValidator.validateEmptyText('Stock', value),
                    ),
                  ),
                  const SizedBox(height: fSizes.spaceBtwInputFields),

                  // Pricing
                  Row(
                    children: [
                      // Price
                      Expanded(
                        child: TextFormField(
                          controller: controller.price,
                          decoration: const InputDecoration(labelText: 'Price', hintText: '\$'),
                          validator: (value) => fValidator.validateEmptyText('Price', value),
                        ),
                      ),
                      const SizedBox(width: fSizes.spaceBtwItems),

                      // Sale Price
                      Expanded(
                        child: TextFormField(
                          controller: controller.salePrice,
                          decoration: const InputDecoration(labelText: 'Discounted Price', hintText: '\$'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
