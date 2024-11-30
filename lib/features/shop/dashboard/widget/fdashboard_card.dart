import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/styles/fsection_heading.dart';
import '../../../../utilis/constants/colors.dart';

class fDashboardCard extends StatelessWidget {
  const fDashboardCard({super.key,
    required this.title,
    required this.subTitle,
    this.icon = Iconsax.arrow_up_3,
    this.color = fColors.success,
    required this.stats,
    this.onTap});

  final String title,subTitle;
  final IconData icon;
  final Color color;
  final int stats;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(fSizes.lg),
        child: Column(
          children: [
            //HEADING
            fSectionHeading(
              title: title, textColor: fColors.textSecondary,),
            SizedBox(height: fSizes.spaceBtwSections,),

            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(subTitle, style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,),

                ///Right Side Stats
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                           Icon(
                              icon, color: color,
                              size: fSizes.iconSm),
                          Text("$stats%", style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge!
                              .apply(color: color,
                              overflow: TextOverflow.ellipsis),)
                        ],
                      ),

                      SizedBox(
                        width: 135,
                        child: Text("Compared to Dec 2025 %",
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelMedium,
                            overflow: TextOverflow.ellipsis),)
                    ])

              ],
            )
          ],
        )

    );
  }
}
