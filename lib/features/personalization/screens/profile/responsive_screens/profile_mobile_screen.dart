import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../widgets/form.dart';
import '../widgets/image_meta.dart';

class ProfileMobileScreen extends StatelessWidget {
  const ProfileMobileScreen({super.key});

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
