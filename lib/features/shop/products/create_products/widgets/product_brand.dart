import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/features/shop/brands/model/brand_model.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilis/constants/sizes.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand label
          Text("Brand",style: Theme.of(context).textTheme.headlineSmall,),
          const SizedBox(height: fSizes.spaceBtwItems,),

          // TypeAheadField for brand selection
          TypeAheadField(
            builder: (context, ctr, focusNode){
              return TextFormField(
          focusNode: focusNode,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Select Brand",
                    suffixIcon: Icon(Iconsax.box),
              ));
          },
            suggestionsCallback: (pattern) {
              // return filtered brand suggestions based on the search pattern
              return [
                  BrandModel(id: "id", image: fImages.Acer, name: "Chimdike"),
                  BrandModel(id: "id", image: fImages.Acer, name: "Chimdike"),
              ];

            },
            itemBuilder: (context, suggestion) {
              return  ListTile(title: Text(suggestion.name),);
            }, onSelected: (suggestion) {  },
          )

        ],
      ),
    );
  }
}
