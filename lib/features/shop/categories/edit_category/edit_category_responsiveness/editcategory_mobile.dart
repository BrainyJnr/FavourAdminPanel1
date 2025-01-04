import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../model/category_model.dart';
import '../form/editCategory_Form.dart';

class EditcategoryMobile extends StatelessWidget {
  const EditcategoryMobile({super.key, required this.category});

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
