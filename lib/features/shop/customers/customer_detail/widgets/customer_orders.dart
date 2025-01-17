import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../table/data_table.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      padding: EdgeInsets.all(fSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Orders",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(text: "Total Spent"),
                TextSpan(
                    text: " \$44.4",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: fColors.primary)),
                TextSpan(
                    text: ' on ${5} Orders',
                    style: Theme.of(context).textTheme.bodyMedium)
              ]))
            ],
          ),
          SizedBox(
            height: fSizes.spaceBtwItems,
          ),
          TextFormField(
            onChanged: (query) {},
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black12, // Border color when enabled
                  width: 1.5,
                ),
              ),
              hintText: "Search Order",
              prefixIcon: Icon(Iconsax.search_normal),
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
          SizedBox(
            height: fSizes.spaceBtwSections,
          ),
          CustomerOrderTable()
        ],
      ),
    );
  }
}
