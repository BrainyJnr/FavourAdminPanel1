import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../loaders/floaders.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxList<ConnectivityResult> _connectionStatus = <ConnectivityResult>[].obs;

  ///Initialize the network manager and set up a stream to continually check the connection status.
  @override
  void onInit () {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// update the connection status based on change in connectivity and show a relevant popup for no internet connection.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus.value = result;
    if (result.contains(ConnectivityResult.none)) {
      fLoaders.customToast(message: "No Internet Connection");
    }
  }

  /// Check the Internet connection status.
  /// Returns 'true' if connected 'false' otherwise
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Dispose or close the active connectivity stream.
  @override
  void onClose()  {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}