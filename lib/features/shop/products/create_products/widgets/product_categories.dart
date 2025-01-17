import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/features/shop/categories/model/category_model.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Categories",style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: fSizes.spaceBtwItems,),

          // MultiSelectDialogField for selecting categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: MultiSelectDialogField(
              buttonText: Text("Select Categories"),
              title: Text("Categories"),
              items: [
                MultiSelectItem(CategoryModel(id: "id", name: "shoes", image: "image"), "shoes"),
                MultiSelectItem(CategoryModel(id: "id", name: "shoes", image: "image"), "shoes"),
              ],
              listType: MultiSelectListType.CHIP,
              onConfirm: (value) {},
            ),
          ),

        ],
      ),
    );
  }
}
