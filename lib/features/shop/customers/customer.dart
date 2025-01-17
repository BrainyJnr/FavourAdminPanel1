import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/shop/customers/all_customers/responsive_screens/customer_desktop_screen.dart';
import 'package:favour_adminpanel/features/shop/customers/all_customers/responsive_screens/customer_mobile_screen.dart';
import 'package:favour_adminpanel/features/shop/customers/all_customers/responsive_screens/customer_tablet_screen.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return fSiteTemplate(desktop: CustomerDesktopScreen(),tablet: CustomerTabletScreen(),mobile: CustomerMobileScreen(),);
  }
}
