import 'package:favour_adminpanel/data/repositories/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';
import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX local Storage
  await GetStorage.init();

  //Remove & sign from url
  setPathUrlStrategy();

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  .then((value) => Get.put(AuthenticationRepository()));

  // Main App Starts here
  runApp(const App());
}

