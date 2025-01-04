import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:favour_adminpanel/features/media/controller/media_controller.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../widget/media_content.dart';
import '../widget/media_uploaded.dart';

class Mediadesktopscreen extends StatelessWidget {
  const Mediadesktopscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(fSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Breadcrumbs
                fBreadCrumbsWithHeading(heading: 'Media', breadcrumbItems: [fRoutes.login,fRoutes.forgetPassword,"Media Screen"],returnToPreviousScreen: true,),


                SizedBox(
                  width: fSizes.buttonWidth * 1.0,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: fColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      onPressed: () => controller.showImagesUploadSection.value = !controller.showImagesUploadSection.value,
                      icon: const Icon(Iconsax.cloud_add,color: fColors.white,),
                      label: const Text("Upload Images",style: TextStyle(color: Colors.white),),
                    ),
                  ),

              ],
            ),
            SizedBox(height: fSizes.spaceBtwSections,),

            /// Upload Area
            MediaUploaded(),


            /// Media
            MediaContent(allowSelection: false,allowMultipleSection: false,)

          ],
        ),),
      ),
    );
  }
}
