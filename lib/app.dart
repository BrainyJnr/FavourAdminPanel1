import 'package:favour_adminpanel/routes/app_routes.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/theme/fApp_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/general_binding.dart';



class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "",
      themeMode: ThemeMode.light,
      darkTheme: fAppTheme.darkTheme,
      getPages: fAppRoute.pages,
      initialRoute: fRoutes.dashboard,
      initialBinding: GeneralBindings(),
      unknownRoute: GetPage(
          name: '/page-not-found',
          page: () => const Scaffold(
                body: Center(
                  child: Text('Page Not Found'),
                ),
              )),
    );
  }
}


