import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../utilis/constants/sizes.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stock
        FractionallySizedBox(
          widthFactor: 0.45,
          child: TextFormField(
            decoration: InputDecoration(labelText: "Stock",hintText: "Add Stock, only numbers are allowed",
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
            validator: (value) => fValidator.validateEmptyText("Stock", value),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],

            ),
          ),
        
        const SizedBox(height: fSizes.spaceBtwInputFields,),
        
        // Pricing
        Row(
          children: [
            // Price
            Expanded(child: TextFormField(
              decoration: const InputDecoration(labelText: "Price",hintText: "Price with up-to 2 decimals"),
              validator: (value) => fValidator.validateEmptyText("Price", value),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
              ],
            )),
            const SizedBox(width: fSizes.spaceBtwItems,),
            
            // Sale Price
            Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Disconnected Price",hintText: "Price with up-to 2 decimals"),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
                  ],
                )),


          ],
        ),

        const SizedBox(width: fSizes.spaceBtwItems,),

        TextFormField(
          decoration: InputDecoration(
            labelText: "Description",hintText: "Add Discription of this variation..."
          ),
        ),
        const SizedBox(width: fSizes.spaceBtwSections,),


      ],
    ));
  }
}
