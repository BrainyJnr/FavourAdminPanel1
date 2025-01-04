import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilis/constants/colors.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: fColors.primaryBackground,
        ),
        const SizedBox(
          height: fSizes.spaceBtwSections,
        ),

        Text(
          "Add Product Attributes",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: fSizes.spaceBtwItems,
        ),

        Form(
            child: fDeviceUtilis.isDesktopScreen(context)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildAttributeName()),
                      SizedBox(
                        height: fSizes.spaceBtwItems,
                      ),
                      Expanded(flex: 2, child: _buildAttributeTextfield()),
                      SizedBox(
                        width: fSizes.spaceBtwItems,
                      ),
                      _buildAddAttributeButton(),
                    ],
                  )
                : Column(
                    children: [
                      _buildAttributeName(),
                      SizedBox(
                        height: fSizes.spaceBtwItems,
                      ),
                      _buildAttributeTextfield(),
                      SizedBox(
                        height: fSizes.spaceBtwItems,
                      ),
                      _buildAddAttributeButton(),
                    ],
                  )),
        SizedBox(
          height: fSizes.spaceBtwSections,
        ),

        // List of added attributes
        Text(
          "All Attributes",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: fSizes.spaceBtwItems,
        ),

        // Display added attributes
        fRoundedContainer(
          backgroundColor: fColors.primaryBackground,
          child: Column(
            children: [
              buildAttributesList(context),
              buildEmptyAttributes(),
            ],
          ),
        ),
        SizedBox(
          height: fSizes.spaceBtwSections,
        ),

        // Generate Variation Button
        Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton.icon(
                icon: Icon(Iconsax.activity),
                onPressed: () {},
                label: Text("Generate Variations")),
          ),
        )
      ],
    );
  }

  Column buildEmptyAttributes() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            fRoundedImage(
              padding: fSizes.chi,
              width: 150,
              height: 80,
              imageType: ImageType.asset,
                image: fImages.Animation1,
            )
          ],
        ),
        SizedBox(
          height: fSizes.spaceBtwItems,
        ),
        Text("There are no attributes added for this product"),
      ],
    );
  }

  ListView buildAttributesList(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
              color: fColors.white,
              borderRadius: BorderRadius.circular(fSizes.borderRadiusLg)),
          child: ListTile(
            title: Text("Color"),
            subtitle: Text("Color, Orange, Pink"),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.trash,
                  color: fColors.error,
                )),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(
        height: fSizes.spaceBtwItems,
      ),
      itemCount: 3,
      shrinkWrap: true,
    );
  }

  SizedBox _buildAddAttributeButton() {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(Iconsax.add),
        label: Text("Add"),
        style: ElevatedButton.styleFrom(
          foregroundColor: fColors.black,
          backgroundColor: fColors.secondary,
        ),
      ),
    );
  }

  TextFormField _buildAttributeName() {
    return TextFormField(
      validator: (value) =>
          fValidator.validateEmptyText("Attribute Name", value),
      decoration: InputDecoration(
        labelText: "Decoration Name",
        hintText: "Colors, Sizes, Material",
      ),
    );
  }

  SizedBox _buildAttributeTextfield() {
    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) =>
            fValidator.validateEmptyText("Attribute Field", value),
        decoration: InputDecoration(
            labelText: "Attributes",
            hintText:
                "Add attributes seperated by | Example: Green | Blue | Yellow",
            alignLabelWithHint: true),
      ),
    );
  }
}
