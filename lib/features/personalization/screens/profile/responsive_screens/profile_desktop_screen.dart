import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/form.dart';
import '../widgets/image_meta.dart';

class ProfileDesktopScreen extends StatelessWidget {
  const ProfileDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BreadCrumbs
            fBreadCrumbsWithHeading(heading: "Profile", breadcrumbItems: ["Profile"]),
            const SizedBox(height: fSizes.spaceBtwSections,),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Pics And Meta
                Expanded(child: ImageAndMeta()),
                const SizedBox(width: fSizes.spaceBtwSections,),

                // Form
                Expanded(flex: 1, child: ProfileForm())
              ],
            )
          ],
        ),),
      ),
    );
  }
}
