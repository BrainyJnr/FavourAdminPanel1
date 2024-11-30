import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/sizes.dart';

class fDeviceUtilis {

  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  static Future<void> setPreferredOrientations(
      List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup("example.com");
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static bool isIOS() {
    return Platform.isIOS;
  }

  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static bool isDesktopScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= fSizes.desktopScreenSize;
  }

  static bool isTabletScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= fSizes.tabletScreenSize &&
        MediaQuery.of(context).size.width < fSizes.desktopScreenSize;
  }

  static bool isMobileScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < fSizes.tabletScreenSize;
  }
}
