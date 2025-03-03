import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../utilis/constants/sizes.dart';
import '../../../controller/category_controller.dart';
import '../../controller/create_product_controller.dart';


class ProductCategories extends StatelessWidget {
  const ProductCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get instance of the CategoryController
    final categoriesController = Get.put(CategoryController());

    // Fetch categories if the list is empty
    if (categoriesController.allItems.isEmpty) {
      categoriesController.fetchItems();
    }

    return fRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: fSizes.spaceBtwItems),

          // MultiSelectDialogField for selecting categories
          Obx(
            () => categoriesController.isLoading.value
                ? const fShimmerEffect(width: double.infinity, height: 50)
                : MultiSelectDialogField(
                    buttonText: const Text("Select Categories"),
                    title: const Text("Categories"),
                    items: categoriesController.allItems.map((category) => MultiSelectItem(category, category.name)).toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      CreateProductController.instance.selectedCategories.assignAll(values);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
