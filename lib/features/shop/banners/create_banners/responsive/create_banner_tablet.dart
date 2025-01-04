import 'package:favour_adminpanel/features/shop/banners/widget/create_banner_form.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';

class CreateBannerTablet extends StatelessWidget {
  const CreateBannerTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(fSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const fBreadCrumbsWithHeading(returnToPreviousScreen: true,
                    heading: "Create Banner", breadcrumbItems: [fRoutes.categories,"Create Banner"]),
                const SizedBox(
                  height: fSizes.spaceBtwSections,
                ),

                // Form
                CreateBannerForm()
              ],
            ),
          ),
        ));
  }
}
