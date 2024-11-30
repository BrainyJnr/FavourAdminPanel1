import 'package:flutter/material.dart';

import '../../layouts/headers/header.dart';

class MobileLayout extends StatelessWidget {
  final Widget? body;

   MobileLayout({super.key, this.body});

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
