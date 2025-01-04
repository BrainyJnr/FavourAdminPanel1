import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductAttribute extends StatelessWidget {
  const ProductAttribute({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: fColors.primaryBackground,),
        SizedBox(height: fSizes.spaceBtwItems,),

        // Form to add new attribute

        // List of Added Attributes
        Text("All Attributes",style: Theme.of(context).textTheme.headlineSmall,
        ),SizedBox(height: fSizes.spaceBtwItems,),

        // Display added attributes in a rounded container
        fRoundedContainer(
          backgroundColor: fColors.primaryBackground,
          child: Column(
            children: [
              buildAttributesList(context),
              buildEmptyAttributes(),
            ],
          ),
        ),
        SizedBox(height: fSizes.spaceBtwSections,),

        // Generate Variation Button
        Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton.icon(onPressed: (){},
                icon: Icon(Iconsax.activity),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          fRoundedImage(
              width: 150,
              height: 80,
              imageType: ImageType.asset,
              image: fImages.Acer,
              padding: fSizes.chi)
        ],
      )
    ],
  );
}

ListView buildAttributesList(BuildContext context) {
  return ListView.separated(
      shrinkWrap: true,

      separatorBuilder: (_, __) => SizedBox(height: fSizes.spaceBtwItems,),
      itemCount: 3,  itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            color: fColors.white,
            borderRadius: BorderRadius.circular(fSizes.borderRadiusLg)
          ),
          child: ListTile(
            title: Text("Color"),
            subtitle: Text("Green, Orange, Pink"),
            trailing: IconButton(onPressed: (){}, icon: Icon(Iconsax.trash,color: fColors.error,)),
          ),
        );
  },
  );
}

SizedBox _buildAddAttributeButton() {
  return SizedBox(
    width: 100,
    child: ElevatedButton.icon(onPressed: () {},
        icon: Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
            foregroundColor: fColors.black,
            backgroundColor: fColors.secondary,
            side: BorderSide(color: fColors.secondary,)
        ),
        label: Text("Add")),
  );
}

// Build text form field for attributes name
TextFormField __buildAttributeName() {
  return TextFormField(
    validator: (value) => fValidator.validateEmptyText("Attribute Name", value),
    decoration: InputDecoration(
      labelText: "Attribute Name", hintText: "Colors, Sizes, Material",),

  );
}
// Build text form field for attributes value
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
          hintText: "Add attribute seperated by | Example: Green | Blue | Yellow",
          alignLabelWithHint: true
      ),
    ),
  );
}}







