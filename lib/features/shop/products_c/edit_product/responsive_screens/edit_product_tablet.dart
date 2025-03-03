import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:flutter/material.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utilis/constants/sizes.dart';


class CreateProductTabletScreen extends StatelessWidget {
  const CreateProductTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fBreadCrumbsWithHeading(
                  returnToPreviousScreen: true, heading: 'Create Product', breadcrumbItems: [fRoutes.products, 'Create Product']),
              SizedBox(height: fSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
