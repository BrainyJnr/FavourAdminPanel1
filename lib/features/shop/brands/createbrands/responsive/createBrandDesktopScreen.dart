import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../widget/create_brand_form.dart';

class CreateBrandDesktopScreen extends StatelessWidget {
  const CreateBrandDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            fBreadCrumbsWithHeading(returnToPreviousScreen: true, heading: "Create Brand", breadcrumbItems: [fRoutes.categories,"Create Brand"]),
            SizedBox(height: fSizes.spaceBtwSections,),

            // Form
            CreateBrandForm()
          ],
        ),),
      ),
    );
  }
}
