import 'package:favour_adminpanel/common/styles/fcircular_image.dart';
import 'package:favour_adminpanel/features/personalization/contorller/settings_controller.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              Row(
                children: [
                  Obx(() =>
                 fCircular_Images(
                  width: 100,
                  height: 100,
                  imageType: SettingsController.instance.settings.value.appLogo.isNotEmpty ? ImageType.network : ImageType.asset,
                  image: SettingsController.instance.settings.value.appLogo.isNotEmpty ?
                      SettingsController.instance.settings.value.appLogo
                  : fImages.favour,
                  backgroundColor: Colors.transparent,
                ),
              ),
              Expanded(child: Obx(() => Text(SettingsController.instance.settings.value.appName,
              style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              )))]),
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
                    FMenuItem(
                      route: fRoutes.categories,
                      icon: Iconsax.category,
                      itemName: "Categories",
                    ),
                    FMenuItem(
                      route: fRoutes.brands,
                      icon: Iconsax.dcube,
                      itemName: "Brands",
                    ),
                    FMenuItem(
                      route: fRoutes.banners,
                      icon: Iconsax.picture_frame,
                      itemName: "Banners",
                    ),
                    FMenuItem(
                      route: fRoutes.products,
                      icon: Iconsax.shopping_bag,
                      itemName: "Products",
                    ),
                    FMenuItem(
                      route: fRoutes.customers,
                      icon: Iconsax.profile_2user,
                      itemName: "Customers",
                    ),
                    FMenuItem(
                      route: fRoutes.orders,
                      icon: Iconsax.box,
                      itemName: "Orders",
                    ),

                    // Other Menu Item
                    Text("OTHER",style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),),
                    FMenuItem(
                      route: fRoutes.profile,
                      icon: Iconsax.user,
                      itemName: "Profile",
                    ),
                    FMenuItem(
                      route: fRoutes.settings,
                      icon: Iconsax.setting_2 ,
                      itemName: "Settings",
                    ),
                    FMenuItem(
                      route: "logout",
                      icon: Iconsax.logout,
                      itemName: "Logout",
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
