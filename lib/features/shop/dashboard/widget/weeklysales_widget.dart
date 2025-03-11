import 'package:favour_adminpanel/common/widgets/icons/fcircular_icon.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/styles/frounded_container.dart';
import '../../../../common/widgets/loaders/fanimation.dart';
import '../../../../utilis/constants/colors.dart';
import '../../../../utilis/constants/sizes.dart';
import '../../../../utilis/device/device_utility.dart';
import '../controller/dashboard_controller.dart';

class fWeeklySalesGraph extends StatelessWidget {
  const fWeeklySalesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return  fRoundedContainer(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              fCircularIcon(icon: Iconsax.graph,
              backgroungColor: Colors.brown.withOpacity(0.1),
              color: Colors.brown,
              size: fSizes.md,),

          Padding(padding: EdgeInsets.only(left: 20),
            child: Text(
              "Weekly Sales",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),
          ),]),
          SizedBox(
            height: fSizes.spaceBtwSections,
          ),

          //Graph
          Obx(
            () => controller.weeklySales.isNotEmpty
    ?
                SizedBox(
              height: 300,
              child: BarChart(BarChartData (
                  titlesData: buildFlTitlesData(controller.weeklySales),
                  borderData: FlBorderData(
                      show: true,
                      border: Border(
                          top: BorderSide.none,
                          right: BorderSide.none)),
                  gridData: const FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: true,
                      horizontalInterval: 200),
                  barGroups: controller.weeklySales.asMap().entries.map(
                        (entry) {
                      return BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            toY: entry.value,
                            color: fColors.primary,
                            width: 30,
                            borderRadius: BorderRadius.circular(fSizes.sm),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                  groupsSpace: fSizes.spaceBtwItems,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(getTooltipColor: (_) => fColors.secondary),
                    touchCallback: fDeviceUtilis.isDesktopScreen(context) ? (barTouchEvent, barTouchResponse) {} : null,
                  )
              )),
            )
                : const SizedBox( height: 400,child: Row(
              mainAxisAlignment: MainAxisAlignment.center,children: [fLoaderAnimation()],
            ),)
          )
        ],
      ),
    );
  }
}

FlTitlesData buildFlTitlesData(
    List<double> weeklySales
    ) {
  // Calculate stop height for the left pricing
  double maxOrder = weeklySales.reduce((a, b) => a > b ? a: b).toDouble();
  double stepHeight = (maxOrder / 10).ceilToDouble();

  return FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
        sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta){
              //Map index to the desired day of the week
              final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

              //Calculate the index and ensure it wraps around for the correct day
              final index = value.toInt() % days.length;

              //Get the day corresponding to the calculated index
              final day = days[index];

              return SideTitleWidget(child: Text(day), axisSide: AxisSide.bottom,space: 0,);
            }
        )
    ),
    leftTitles:  AxisTitles(sideTitles: SideTitles(showTitles: true,interval: stepHeight <= 0 ? 500 : stepHeight,reservedSize: 50)),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false,)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false,)),
  );
}
