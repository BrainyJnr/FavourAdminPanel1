import 'package:favour_adminpanel/features/personalization/screens/settings/widget/image_and_metasettings.dart';
import 'package:favour_adminpanel/features/personalization/screens/settings/widget/settings_from.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utilis/constants/sizes.dart';

class SettingsMobileScreen extends StatelessWidget {
  const SettingsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BreadCrumbs
              fBreadCrumbsWithHeading(heading: "Settings", breadcrumbItems: ["Settings"]),
              const SizedBox(height: fSizes.spaceBtwSections,),

              // Body
              Column(
                children: [
                  ImageAndMetaSettings(),
                  const SizedBox(width: fSizes.spaceBtwSections,),

                  // Form
                  SettingsFrom()
                ],
              )
            ],
          ),),
      ),
    );
  }
}
