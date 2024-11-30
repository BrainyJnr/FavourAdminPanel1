import 'package:favour_adminpanel/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../common/widgets/layouts/sidebars/sidebar_controller.dart';

class RouteObservers extends GetObserver {

   @override
   void didPop(Route route, Route? previousRoute) {
     final sidebarController = Get.put(SidebarController());

     if(previousRoute != null) {
       // Check the route name update the active item in the sidebar accordingly
      for(var routeName in fRoutes.sideMenuItems)
         if(previousRoute.settings.name == routeName) {
           sidebarController.activeItem.value = routeName;
         }
     }
   }
 }
//
//  @override
//  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
//   final sidebarController = Get.put(sidebarController());
//
//   if(route != null) {
//     // Check the route name  update the active item in the sidebar accordingly
//     for(var routeName in fRoutes.sideMenuItem) {
//       if(route.settings.name == routeName) {
//         sidebarController.activeItem.value.routeName;
//       }
//
//     }
//   }
//  }