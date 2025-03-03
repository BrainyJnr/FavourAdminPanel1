import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:flutter/material.dart';

import '../../../../../utilis/constants/sizes.dart';
import '../../all_products/model/product_model.dart';
import '../../controller/edit_product_controller.dart';



class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard button
          OutlinedButton(
            onPressed: () {
              // Add functionality to discard changes if needed
            },
            child: const Text('Discard'),
          ),
          const SizedBox(width: fSizes.spaceBtwItems / 2),

          // Save Changes button
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () => EditProductController.instance.editProduct(product),
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}
