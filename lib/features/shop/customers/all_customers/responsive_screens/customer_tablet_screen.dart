import 'package:flutter/material.dart';

import '../../../../../common/styles/frounded_container.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../table/data_table.dart';

class CustomerTabletScreen extends StatelessWidget {
  const CustomerTabletScreen({super.key});

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
