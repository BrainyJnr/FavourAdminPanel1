import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilis/constants/sizes.dart';
import '../../../brands/controller/brand_controller.dart';
import '../../controller/edit_product_controller.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get instances of controllers
    final controller = Get.put(EditProductController());
    final brandController = Get.put(BrandController());

    // Fetch brands if the list is empty
    if (brandController.allItems.isEmpty) {
      brandController.fetchItems();
    }

    return fRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand label
          Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: fSizes.spaceBtwItems),

          // TypeAheadField for brand selection
          Obx(
            () => brandController.isLoading.value
                ? const fShimmerEffect(width: double.infinity, height: 50)
                : TypeAheadField(
                    controller: controller.brandTextField,
                    builder: (context, ctr, focusNode) {
                      return TextFormField(
                        focusNode: focusNode,
                        controller: ctr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Select Brand',
                          suffixIcon: Icon(Iconsax.box),
                        ),
                      );
                    },
                    suggestionsCallback: (pattern) {
                      // Return filtered brand suggestions based on the search pattern
                      return brandController.allItems.where((brand) => brand.name.contains(pattern)).toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.name),
                      );
                    },
                    onSelected: (suggestion) {
                      controller.selectedBrand.value = suggestion;
                      controller.brandTextField.text = suggestion.name;
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
