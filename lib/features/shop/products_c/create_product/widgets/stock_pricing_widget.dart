import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../utilis/constants/enums.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../controller/create_product_controller.dart';


class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

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
                      decoration: const InputDecoration(labelText: 'Stock', hintText: 'Add Stock, only numbers are allowed'),
                      validator: (value) => fValidator.validateEmptyText('Stock', value),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
                          decoration: const InputDecoration(labelText: 'Price', hintText: 'Price with up-to 2 decimals'),
                          validator: (value) => fValidator.validateEmptyText('Price', value),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                          ],
                        ),
                      ),
                      const SizedBox(width: fSizes.spaceBtwItems),

                      // Sale Price
                      Expanded(
                        child: TextFormField(
                          controller: controller.salePrice,
                          decoration: const InputDecoration(labelText: 'Discounted Price', hintText: 'Price with up-to 2 decimals'),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                          ],
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
