import 'package:favour_adminpanel/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

import '../../layouts/headers/header.dart';

class TabletLayout extends StatelessWidget {

  TabletLayout({super.key, this.body});
  final Widget? body;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: const Drawer(),
        appBar: fHeader(scaffoldKey: scaffoldKey,),
        body: body ??
            Container());
  }
}
