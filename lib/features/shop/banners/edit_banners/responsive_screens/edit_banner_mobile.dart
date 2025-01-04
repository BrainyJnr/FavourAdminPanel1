import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../model/banner_model.dart';
import '../../widget/edit_banner_form.dart';

class EditBannerMobile extends StatelessWidget {
  const EditBannerMobile({super.key, required this.banner});

  final BannerModel banner;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(fSizes.defaultSpace),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // BreadCrumbs
            const fBreadCrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: "Update Banner",
                breadcrumbItems: [fRoutes.categories]),
            const SizedBox(
              height: fSizes.spaceBtwSections,
            ),

            // Form
            EditBannerForm(
              banner: banner,
            )
          ]),
        ),
      ),
    );
  }
}
