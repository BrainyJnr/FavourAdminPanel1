import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:favour_adminpanel/features/shop/categories/edit_category/edit_category_responsiveness/editcategory_desktop.dart';
import 'package:favour_adminpanel/features/shop/categories/edit_category/edit_category_responsiveness/editcategory_mobile.dart';
import 'package:favour_adminpanel/features/shop/categories/edit_category/edit_category_responsiveness/editcategory_tablet.dart';
import 'package:favour_adminpanel/features/shop/categories/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditCategoryscreen extends StatelessWidget {
  const EditCategoryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments;
    return fSiteTemplate(
      desktop: EditcategoryDesktop(category: category,),
      tablet: EditcategoryTablet(category: category),
      mobile: EditcategoryMobile(category: category),
    );
  }
}
