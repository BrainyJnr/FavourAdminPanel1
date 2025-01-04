import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
import 'package:flutter/material.dart';

import '../../../../../utilis/constants/sizes.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
        child: Form(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Basic Information",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(
        height: fSizes.spaceBtwItems,
      ),
      // Basic Information Text
      TextFormField(
        validator: (value) =>
            fValidator.validateEmptyText("Product Title", value),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black12, // Border color when enabled
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            // Border when not focused
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black12, // Border color when enabled
              width: 1.5,
            ),
          ),
          labelText: "Product Title",
        ),
      ),
      const SizedBox(
        height: fSizes.spaceBtwInputFields,
      ),

      // Product Description Input Field
      SizedBox(
        height: 300,
        child: TextFormField(
          expands: true,
          maxLines: null,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.multiline,
          textAlignVertical: TextAlignVertical.top,
          validator: (value) =>
              fValidator.validateEmptyText("Product Description", value),
          decoration: InputDecoration(
            labelText: "Product Description",
            hintText: "Add your Product Description here......",
            alignLabelWithHint: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black12, // Border color when enabled
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              // Border when not focused
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black12, // Border color when enabled
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    ])));
  }
}
