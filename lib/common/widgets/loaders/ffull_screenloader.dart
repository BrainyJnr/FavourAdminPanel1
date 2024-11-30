import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utilis/constants/colors.dart';
import '../../../utilis/constants/image_strings.dart';
import '../../../utilis/helpers/helper_function.dart';
import 'fAnimationLoaderWidget.dart';

class fFullScreenLoader {


  static void openLoadingDialog(String text, String animation) {
    // JsonReader jsonReader = new JsonReader(new StringReader(malformedString));
    //   jsonReader.setLenient(true);
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: fHelperFunctions.isDarkMode(Get.context!) ? fColors.dark : fColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250,),
                  fAnimationLoaderWidget(text: text, image: fImages.Animation1)
                ],
              ),
            )));}

  /// Stop the currently open loading dialog
  /// This method doesn't return anything
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();

  }
}