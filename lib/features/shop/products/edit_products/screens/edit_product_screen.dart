import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/shop/products/edit_products/responsive_screen/edit_desktop_screen.dart';
import 'package:favour_adminpanel/features/shop/products/edit_products/responsive_screen/edit_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments;
    return fSiteTemplate(desktop: EditDesktopScreen(product: product,),mobile: EditMobileScreen(product: product,),);
  }
}
