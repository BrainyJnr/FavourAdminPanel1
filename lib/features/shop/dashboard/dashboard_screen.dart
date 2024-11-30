import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/shop/dashboard/responsive_dashboard/dashboarddesktopscreen.dart';
import 'package:favour_adminpanel/features/shop/dashboard/responsive_dashboard/dashboardmobilescreen.dart';
import 'package:favour_adminpanel/features/shop/dashboard/responsive_dashboard/dashboardtabletscreen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const fSiteTemplate(
      desktop: Dashboarddesktopscreen(),
      tablet: Dashboardtabletscreen(),
      mobile: Dashboardmobilescreen(),
    );
  }
}
