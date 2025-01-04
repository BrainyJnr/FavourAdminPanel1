import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:flutter/material.dart';

import '../../../../../utilis/constants/sizes.dart';

class ProductBottomNavigationbuttons extends StatelessWidget {
  const ProductBottomNavigationbuttons({super.key});

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard button
          OutlinedButton(onPressed: (){}, child: Text("Discard")),
          const SizedBox(width: fSizes.spaceBtwItems / 2,),

          // Save Changes button
          SizedBox(width: 160,child: ElevatedButton(onPressed: (){}, child: Text("Save Changes")),)
        ],
      ),
    );
  }
}
