import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/data_table/table_header.dart';
import '../table/data_table.dart';

class CustomerDesktopScreen extends StatelessWidget {
  const CustomerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BreadCrumbs
            fBreadCrumbsWithHeading(heading: "Customers", breadcrumbItems: ['Customers']),
            SizedBox(height: fSizes.spaceBtwSections,),

            fRoundedContainer(
              child: Column(
                children: [
                // Table Header
                TableHeader(showLeftWidget: false,),
                  SizedBox(height: fSizes.spaceBtwItems,),

                  // Table
                  CustomerTable()

                ]            )
            )],
        ),),
      ),
    );
  }
}
