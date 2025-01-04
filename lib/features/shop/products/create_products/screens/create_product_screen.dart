import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/shop/products/create_products/screens/responsiveness/create_productdesktop_screen.dart';
import 'package:favour_adminpanel/features/shop/products/create_products/screens/responsiveness/create_productmobile_screen.dart';
import 'package:favour_adminpanel/features/shop/products/create_products/screens/responsiveness/create_producttablet_screen.dart';
import 'package:flutter/material.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return fSiteTemplate(desktop: CreateProductdesktopScreen(),mobile: CreateProductmobileScreen(),

    );
  }
}
