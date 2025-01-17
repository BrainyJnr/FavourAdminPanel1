import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/common/widgets/data_table/table_header.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../table/data_table.dart';

class OrderDesktopScreen extends StatelessWidget {
  const OrderDesktopScreen({super.key});

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
