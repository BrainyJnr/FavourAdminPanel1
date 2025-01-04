import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/features/shop/categories/edit_category/form/editCategory_Form.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../model/category_model.dart';

class EditcategoryDesktop extends StatelessWidget {
  const EditcategoryDesktop({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            fBreadCrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: "Update Category", breadcrumbItems: [fRoutes.categories, "Update Category"]),
            const SizedBox(height: fSizes.spaceBtwSections,),

            // Form
            EditcategoryForm(category: category)
          ],
        ),),
      ),
    );
  }
}
