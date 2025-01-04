import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../all_categories/widget/category_form.dart';

class CreateCategoryscreen extends StatelessWidget {
  const CreateCategoryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BreadCrumbs
            fBreadCrumbsWithHeading(returnToPreviousScreen: true, heading: "Create Category", breadcrumbItems: [fRoutes.categories, "Create Category"]),
            SizedBox(height: fSizes.spaceBtwSections,),

            // Form
            CreateCategoryForm()
          ],
        ),),
      ),
    );
  }
}
