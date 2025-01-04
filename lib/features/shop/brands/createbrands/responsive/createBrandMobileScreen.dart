import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../widget/create_brand_form.dart';

class CreateBrandMobileScreen extends StatelessWidget {
  const CreateBrandMobileScreen({super.key});

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
