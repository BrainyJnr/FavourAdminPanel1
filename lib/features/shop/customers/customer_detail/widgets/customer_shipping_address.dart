import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      padding: const EdgeInsets.all(fSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Shipping Address",style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: fSizes.spaceBtwSections,),

          // Meta Data
          Row(
            children: [
              const SizedBox(width: 120,child: Text("Name"),),
              Text(":"),
              SizedBox(width: fSizes.spaceBtwItems / 2,),
              Expanded(child: Text("Godwin Chimdike Favour",style: Theme.of(context).textTheme.titleSmall,)),
            ],
          ),
          SizedBox(height: fSizes.spaceBtwItems / 2,),
          Row(
            children: [
              SizedBox(width: 120,child: Text("Country"),),
              Text(":"),
              Expanded(child: Text("United Kingdom",style: Theme.of(context).textTheme.titleSmall,)),
            ],
          ),
      SizedBox(height: fSizes.spaceBtwItems / 2,),
      Row(
        children: [
          SizedBox(width: 120,child: Text("Phone Number"),),
          Text(":"),
          Expanded(child: Text("+22222222222222222222",style: Theme.of(context).textTheme.titleSmall,)),]),

      SizedBox(height: fSizes.spaceBtwItems / 2,),
      Row(
        children: [
          SizedBox(width: 120,child: Text("Address"),),
          Text(":"),
          Expanded(child: Text("2 Douglas House",style: Theme.of(context).textTheme.titleSmall,)),
       ]) ],
      ),
    );
  }
}
