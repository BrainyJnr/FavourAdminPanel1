import 'package:flutter/material.dart';

import '../../../../../common/styles/frounded_container.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../table/data_table.dart';

class OrderMobileScreen extends StatelessWidget {
  const OrderMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BreadCrumbs
              fBreadCrumbsWithHeading(heading: "Orders", breadcrumbItems: ['Orders']),
              SizedBox(height: fSizes.spaceBtwSections,),

              // Table Body
              fRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TableHeader(showLeftWidget: false,),

                    // Table
                    OrderTable()
                  ],
                ),
              )

            ],
          ),),
      ),
    );
  }
}
