import 'package:favour_adminpanel/features/shop/brands/model/brand_model.dart';
import 'package:favour_adminpanel/features/shop/brands/widget/edit_brand_form.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';

class EditBrandDesktopScreen extends StatelessWidget {
  const EditBrandDesktopScreen({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fBreadCrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: "Update Brand",
                  breadcrumbItems: [fRoutes.categories, "Update Brand"]),
              SizedBox(
                height: fSizes.spaceBtwSections,
              ),

              // Form
              EditBrandForm(brand: brand)
            ],
          ),
        ),
      ),
    );
  }
}
