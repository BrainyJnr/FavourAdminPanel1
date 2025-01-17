import 'package:favour_adminpanel/features/personalization/screens/profile/widgets/image_meta.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../widgets/form.dart';

class ProfileTabletScreen extends StatelessWidget {
  const ProfileTabletScreen({super.key});

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
              Column(
                children: [
                  ImageAndMeta(),
                  const SizedBox(width: fSizes.spaceBtwSections,),

                  // Form
                  ProfileForm()
                ],
              )
            ],
          ),),
      ),
    );
  }
}
