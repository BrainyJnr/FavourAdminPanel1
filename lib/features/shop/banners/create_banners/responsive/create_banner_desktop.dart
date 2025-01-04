import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../widget/create_banner_form.dart';

class CreateBannerDesktop extends StatelessWidget {
  const CreateBannerDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(fSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fBreadCrumbsWithHeading(returnToPreviousScreen: true,
                    heading: "Create Banner", breadcrumbItems: [fRoutes.categories,"Create Banner"]),
                SizedBox(
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
