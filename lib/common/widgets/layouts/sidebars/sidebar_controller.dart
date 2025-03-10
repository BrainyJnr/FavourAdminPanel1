import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:get/get.dart';

class SidebarController extends GetxController {
  final activeItem = fRoutes.dashboard.obs;
  final hoverItem = ''.obs;

  void changeActiveItem(String route) => activeItem.value = route;

  void changeHoverItem(String route) {
    if (!isActive(route)) hoverItem.value = route;
  }

  bool isActive(String route) => activeItem.value == route;

  bool isHovering(String route) => hoverItem.value == route;

  void menuOnTap(String route) {
    if (!isActive(route)) {
      changeActiveItem(route);

      if (fDeviceUtilis.isMobileScreen(Get.context!)) Get.back();
      Get.toNamed(route);
    }
  }

  Future<void> logout() async {
    try {} catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}
