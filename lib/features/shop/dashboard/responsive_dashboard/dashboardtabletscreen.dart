import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../common/styles/frounded_container.dart';
import '../table/data_table.dart';
import '../widget/fdashboard_card.dart';
import '../widget/orderstatus_piechart.dart';
import '../widget/weeklysales_widget.dart';

class Dashboardtabletscreen extends StatelessWidget {
  const Dashboardtabletscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(10),

          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //HEADING
            Text("Dashboard",style: Theme.of(context).textTheme.headlineLarge,),
            const SizedBox(height: fSizes.spaceBtwSections,),

            //CARDS
            Row(
              children: [
                Expanded(child: fDashboardCard(stats: 25, title: "Sales total", subTitle: '\$356',)),
                SizedBox(width: fSizes.spaceBtwItems,),
                Expanded(child: fDashboardCard(stats: 25, title: "Sales total", subTitle: '\$356',)),

              ],
            ),
            Row(
              children: [
                Expanded(child: fDashboardCard(stats: 25, title: "Sales total", subTitle: '\$356',)),
                SizedBox(width: fSizes.spaceBtwItems,),
                Expanded(child: fDashboardCard(stats: 25, title: "Sales total", subTitle: '\$356',)),
                SizedBox(width: fSizes.spaceBtwItems,),

              ],
            ),
                //BAR GRAPH
                fWeeklySalesGraph(),
                SizedBox(
                  height: fSizes.spaceBtwSections,
                ),

            //ORDERS
            fRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recent Orders",style: Theme.of(context).textTheme.headlineSmall,),
                  const SizedBox(height: fSizes.spaceBtwSections,),
                  const DashboardOrderTable()
                ],
              ),
            ),

        SizedBox(
          height: fSizes.spaceBtwSections,
        ),

        //PIE CHART
        OrderstatusPiechart(),
              ],
            )

        ),),

    );  }
}
