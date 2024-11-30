import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/common/widgets/shimmers/shimmer.dart';
import 'package:favour_adminpanel/features_authentication/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utilis/constants/colors.dart';
import '../../../../utilis/constants/enums.dart';
import '../../../../utilis/constants/image_strings.dart';
import '../../../../utilis/constants/sizes.dart';
import '../../../../utilis/device/device_utility.dart';

class fHeader extends StatelessWidget implements PreferredSizeWidget {
  const fHeader({super.key, this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Container(
      decoration: const BoxDecoration(
        color: fColors.white,
        border: Border(bottom: BorderSide(color: fColors.grey, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: fSizes.md, vertical: fSizes.sm),
      child: AppBar(
        leading: !fDeviceUtilis.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                icon: const Icon(Iconsax.menu))
            : null,
        title: fDeviceUtilis.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8), // Optional: To round the corners
                        borderSide: BorderSide(color: Colors.grey), // Set the border color
                      ),
                      prefixIcon: const Icon(Iconsax.search_normal),
                      hintText: "Search anything..."),
                ),
              )
            : null,

        /// Actions
        actions: [
          //search Icon on Mobile
          if (!fDeviceUtilis.isDesktopScreen(context))
            IconButton(onPressed: () {}, icon: Icon(Iconsax.search_normal)),

          //Notification Icon
          IconButton(onPressed: () {}, icon: Icon(Iconsax.notification)),
          const SizedBox(
            width: fSizes.spaceBtwItems / 2,
          ),

          //User Data
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => fRoundedImage(
                  width: 40,
                  height: 40,
                  padding: 2,
                  imageType: controller.user.value.profilePicture.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  image: controller.user.value.profilePicture.isNotEmpty
                      ? controller.user.value.profilePicture
                      : fImages.CircleAvatar2,
                ),
              ),
              SizedBox(
                width: fSizes.sm,
              ),
              if (!fDeviceUtilis.isMobileScreen(context))
                Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.loading.value
                          ? const fShimmerEffect(width: 50, height: 13)
                          : Text(
                              controller.user.value.fullName,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                      controller.loading.value
                          ? const fShimmerEffect(width: 50, height: 13)
                          : Text(
                              controller.user.value.email,
                              style: Theme.of(context).textTheme.labelSmall,
                            )
                    ],
                  ),
                )
            ],
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(fDeviceUtilis.getAppBarHeight() + 15);
}
