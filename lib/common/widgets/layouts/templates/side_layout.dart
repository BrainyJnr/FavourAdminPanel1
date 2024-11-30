import 'package:flutter/material.dart';
import '../../responsive/screens/desktop.dart';
import '../../responsive/screens/mobile.dart';
import '../../responsive/screens/responsive_Widget.dart';
import '../../responsive/screens/tablet.dart';

class fSiteTemplate extends StatelessWidget {
  const fSiteTemplate({super.key,
    this.desktop,
    this.tablet,
    this.mobile,
    this.useLayout = true});

  final Widget? desktop;

  final Widget? tablet;

  final Widget? mobile;

  /// flag to determine whether to use the layout
  final bool useLayout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: fResponsiveWidget(
        desktop: useLayout
            ? DesktopLayout(body: desktop)
            : desktop ?? Container(),
        tablet: useLayout
            ? TabletLayout(body: tablet ?? desktop)
            : tablet ?? desktop ?? Container(),
        mobile: useLayout
            ? MobileLayout(body: mobile ?? desktop)
            : mobile ?? desktop ?? Container(),
      ),
    );
  }
}