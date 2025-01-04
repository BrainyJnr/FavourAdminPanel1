import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateProducttabletSCreen extends StatelessWidget {
  const CreateProducttabletSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            children: [
              fBreadCrumbsWithHeading(
                heading: "Create Product",
                breadcrumbItems: [fRoutes.products, "Create Products"],
              ),
              SizedBox(
                height: fSizes.spaceBtwSections,
              )
            ],
          ),
        ),
      ),
    );
  }
}
