import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Visibility",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: fSizes.spaceBtwItems,
          ),

          // Radio buttons for product visibility
          Column(
            children: [
              _buildVisibityRadioButton(
                  ProductVisibility.published, "Published"),
              _buildVisibityRadioButton(ProductVisibility.hidden, "Hidden"),
            ],
          )
        ],
      ),
    );
  }

  // Helper method to build a radio button for product visibility
  Widget _buildVisibityRadioButton(ProductVisibility value, String label) {
    return RadioMenuButton<ProductVisibility>(
      value: value,
      groupValue: ProductVisibility.published,
      onChanged: (selection) {},
      child: Text(label),
    );
  }
}
