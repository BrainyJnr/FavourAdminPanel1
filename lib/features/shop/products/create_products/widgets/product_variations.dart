import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/common/widgets/uploader/image_uploader.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../utilis/validators/fvalidators.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
       child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Variations Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Product Variations",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Remove Variations"),
                ),
              ],
            ),
            SizedBox(
              height: fSizes.spaceBtwItems,
            ),

            // ListView with shrinkWrap
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return _buildVariationTile();
              },
              separatorBuilder: (_, __) => SizedBox(
                height: fSizes.spaceBtwItems,
              ),
              itemCount: 2,
            ),

            // No Variation Message
            _buildVariationMessage(),
          ],
       )
    );
  }

  // Helper method to build a Variation tile
  Widget _buildVariationTile() {
    return ExpansionTile(
        backgroundColor: fColors.lightGrey,
        collapsedBackgroundColor: fColors.lightGrey,
        childrenPadding: EdgeInsets.all(fSizes.md),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(fSizes.borderRadiusLg)),
        title: Text("Color: Green"),
        children: [
          // Upload Variation Image
          Obx(() => ImageUploader(
                right: 0,
                left: 0,
                image: fImages.Acer,
                onIconButtonPressed: () {},
                imageType: ImageType.asset,
              )),
          SizedBox(
            height: fSizes.spaceBtwInputFields,
          ),

          // Variation Stock and Pricing
          Row(children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  labelText: "Stock",
                  hintText: "Add Stock, only numbers are allowed",
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
            SizedBox(
              width: fSizes.spaceBtwInputFields,
            ),
            Expanded(
                child: TextFormField(
              decoration: const InputDecoration(
                  labelText: "Price", hintText: "Price with up-to 2 decimals"),
              validator: (value) =>
                  fValidator.validateEmptyText("Price", value),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
              ],
            )),
            SizedBox(
              width: fSizes.spaceBtwInputFields,
            ),
            TextFormField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
              ],
              decoration: InputDecoration(
                labelText: "Discounted Price",
                hintText: "Price with up-to 2 decimals",
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
          ]),

          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: "Description",
              hintText: "Add description of this variation...",
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
        ]);
  }

  // Helper method to build message when there are no variations
  Widget _buildVariationMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centers the entire column vertically
        crossAxisAlignment: CrossAxisAlignment.center, // Centers the content horizontally
        children: [
          fRoundedImage(
            padding: fSizes.chi,
            width: 200,
            height: 200,
            imageType: ImageType.asset,
            image: fImages.Animation1,
          ),
          SizedBox(
            height: fSizes.spaceBtwItems,
          ),
          Text("There are no variations added for this product"),
        ],
      ),
    );
  }
}
