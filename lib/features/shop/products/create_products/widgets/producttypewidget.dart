import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:flutter/material.dart';

import '../../../../../utilis/constants/sizes.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Product Type",style: Theme.of(context).textTheme.headlineSmall,),
        const SizedBox(width: fSizes.spaceBtwItems,),
       // Radio Button For Single Product Type
        RadioMenuButton(value: ProductType.single, groupValue: ProductType.single, onChanged: (value){}, child: Text("Single")),

        // Radio Button For Variable Product Type
        RadioMenuButton(value: ProductType.variable, groupValue: ProductType.single, onChanged: (value){}, child: Text("Variable")),



      ],
    );
  }
}
