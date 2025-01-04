import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/features/shop/banners/model/banner_model.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../routes/routes.dart';
import '../../widget/edit_banner_form.dart';

class EditBannerDesktop extends StatelessWidget {
  const EditBannerDesktop({super.key, required this.banner});

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
