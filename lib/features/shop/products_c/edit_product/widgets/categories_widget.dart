import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/utilis/helpers/fcloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../utilis/constants/sizes.dart';
import '../../../categories/model/category_model.dart';
import '../../../controller/category_controller.dart';
import '../../all_products/model/product_model.dart';
import '../../controller/edit_product_controller.dart';



class ProductCategories extends StatelessWidget {
  const ProductCategories({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = EditProductController.instance;

    return fRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: fSizes.spaceBtwItems),

          // MultiSelectDialogField for selecting categories
          FutureBuilder(
              future: productController.loadSelectedCategories(product.id),
              builder: (context, snapshot) {
                final widget = fCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if (widget != null) return widget;

                return MultiSelectDialogField(
                  buttonText: const Text("Select Categories"),
                  title: const Text("Categories"),
                  initialValue: List<CategoryModel>.from(productController.selectedCategories),
                  items: CategoryController.instance.allItems.map((category) => MultiSelectItem(category, category.name)).toList(),
                  listType: MultiSelectListType.CHIP,
                  onConfirm: (values) {
                    productController.selectedCategories.assignAll(values);
                  },
                );
              }),
        ],
      ),
    );
  }
}
