import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utilis/constants/colors.dart';
import '../../../../utilis/constants/sizes.dart';

class FMenuItem extends StatelessWidget {
  const FMenuItem({
    super.key,
    required this.route,
    required this.icon,
    required this.itemName,
  });

  final String route;
  final IconData icon;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    // Use the globally initialized SidebarController instance
    final menuController = Get.put(SidebarController());
    return InkWell(
      onTap: () => menuController.menuOnTap(route),
      onHover: (hovering) => hovering
          ? menuController.changeHoverItem(route)
          : menuController.changeHoverItem(''),
      child: Obx(
            () => Padding(
          padding: const EdgeInsets.symmetric(vertical: fSizes.xs),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: menuController.isHovering(route) || menuController.isActive(route)
                  ? fColors.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(fSizes.cardRadiusMd),
              boxShadow: menuController.isActive(route)
                  ? [
                BoxShadow(
                  color: fColors.primary.withOpacity(0.6),
                  blurRadius: 12,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                )
              ]
                  : [],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: fSizes.md, vertical: fSizes.md),
                  child: Icon(
                    icon,
                    size: 22,
                    color: menuController.isActive(route) || menuController.isHovering(route)
                        ? fColors.white
                        : fColors.darkerGrey,
                  ),
                ),

                // Text
                Flexible(
                  child: Text(
                    itemName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: menuController.isActive(route) || menuController.isHovering(route)
                          ? fColors.white
                          : fColors.darkerGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
