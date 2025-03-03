import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utilis/constants/enums.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../controller/create_product_controller.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());
    return fRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visibility Header
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: fSizes.spaceBtwItems),

          // Radio buttons for product visibility
          Obx(
            () => Column(
              children: [
                _buildVisibilityRadioButton(controller, ProductVisibility.published, 'Published'),
                _buildVisibilityRadioButton(controller, ProductVisibility.hidden, 'Hidden'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a radio button for product visibility
  Widget _buildVisibilityRadioButton(CreateProductController controller, ProductVisibility value, String label) {
    return RadioMenuButton<ProductVisibility>(
      value: value,
      groupValue: controller.productVisibility.value,
      onChanged: (selection) => controller.productVisibility.value = selection ?? ProductVisibility.hidden,
      child: Text(label),
    );
  }
}
