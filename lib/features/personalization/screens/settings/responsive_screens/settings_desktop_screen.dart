import 'package:favour_adminpanel/features/personalization/screens/settings/widget/settings_from.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../profile/widgets/form.dart';
import '../widget/image_and_metasettings.dart';

class SettingsDesktopScreen extends StatelessWidget {
  const SettingsDesktopScreen({super.key});

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pics And Meta
                  Expanded(child: ImageAndMetaSettings()),
                  const SizedBox(width: fSizes.spaceBtwSections,),

                  // Form
                  Expanded(flex: 1, child: SettingsFrom())
                ],
              )
            ],
          ),),
      ),
    );
  }
}
