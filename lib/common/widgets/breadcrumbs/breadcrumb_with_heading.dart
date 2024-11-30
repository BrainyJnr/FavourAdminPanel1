import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/features/media/widget/fpageheading.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class fBreadCrumbsWithHeading extends StatelessWidget {
  const fBreadCrumbsWithHeading({
    super.key,
    required this.heading,
    required this.breadcrumbItems,
    this.returnToPreviousScreen = false,
  });

  // The heading for the page
  final String heading;

  // List of breadcrumb items representing the navigation path
  final List<String> breadcrumbItems;

  // Flag indicating whether to include a button to return to the previous screen
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //BreadCrumbs trail
        Row(children: [
          //BreadCrumbs link

          InkWell(
            onTap: () => Get.offAllNamed(fRoutes.dashboard),
            child: Padding(
              padding: const EdgeInsets.all(fSizes.xs),
              child: Text(
                "Dashboard",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(fontWeightDelta: -1),
              ),
            ),
          ),


        for (int i = 0; i < breadcrumbItems.length; i++)
          Row(
            children: [
              const Text("/"),
              InkWell(
                onTap: i == breadcrumbItems.length - 1
                    ? null
                    : () => Get.offAllNamed(breadcrumbItems[i]),
                child: Padding(
                  padding: EdgeInsets.all(fSizes.xs),

                  // Format breadcrumb item: capitalize and remove leading '/'
                  child: Text(
                    i == breadcrumbItems.length - 1
                        ? breadcrumbItems[i].capitalize.toString()
                        : capitalize(breadcrumbItems[i].substring(1)),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(fontWeightDelta: -1),
                  ),
                ),
              )
            ],
          ),]),
        SizedBox(
          height: fSizes.sm,
        ),

        // Heading of the page
        Row(
          children: [
            if(returnToPreviousScreen) IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
            if(returnToPreviousScreen) const SizedBox(width: fSizes.spaceBtwItems,),
            fPageHeading(heading: heading)
          ],
        )
      ],);
  }

  // Function to capitalize the first letter of a string
  String capitalize(String s) {
    return s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
  }
}
