import 'package:favour_adminpanel/common/styles/fcircular_image.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utilis/constants/colors.dart';
import '../../../../utilis/constants/image_strings.dart';
import '../../../../utilis/constants/sizes.dart';
import '../menu/menu_item.dart';

class fSidebar extends StatelessWidget {
  const fSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
            color: fColors.white,
            border: Border(right: BorderSide(color: fColors.grey, width: 1))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Image
              fCircular_Images(
                width: 100,
                height: 100,
                image: fImages.favour,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                height: fSizes.spaceBtwSections,
              ),
              Padding(
                padding: const EdgeInsets.all(fSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "MENU",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),

                    //Menu Items
                    FMenuItem(
                      route: fRoutes.dashboard,
                      icon: Iconsax.status,
                      itemName: "Dashboard",
                    ),
                    FMenuItem(
                      route: fRoutes.media,
                      icon: Iconsax.image,
                      itemName: "Media",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
