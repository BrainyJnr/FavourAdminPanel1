import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/edit_product_controller.dart';
import 'responsive_screens/edit_product_desktop.dart';
import 'responsive_screens/edit_product_mobile.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    controller.initProductData(product);

    return product != null
        ? fSiteTemplate(desktop: EditProductDesktopScreen(product: product), mobile: EditProductMobileScreen(product: product))
        : const fPageNotFound();
  }
}


class fPageNotFound extends StatelessWidget {
  const fPageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2000,
      width: 2000,
      color: Colors.white,
    );
  }
}
