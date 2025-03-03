import 'package:flutter/material.dart';

import '../../../../../common/styles/frounded_container.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../controller/create_product_controller.dart';



class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({
    super.key,
  });

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
              onPressed: () => CreateProductController.instance.createProduct(),
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}
