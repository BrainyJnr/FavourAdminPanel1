import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilis/constants/colors.dart';
import '../../../../../utilis/constants/sizes.dart';
import '../../../contorller/settings_controller.dart';

class SettingsFrom extends StatelessWidget {
  const SettingsFrom({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return Column(
      children: [
        // App Settings
        fRoundedContainer(
            padding: const EdgeInsets.symmetric(
                vertical: fSizes.lg, horizontal: fSizes.md),
            child: Form(
                key: controller.formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "App Settings",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: fSizes.spaceBtwSections,
                      ),

                      // App Name
                      TextFormField(
                        controller: controller.appNameController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black12,
                                // Border color when enabled
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              // Border when not focused
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black12,
                                // Border color when enabled
                                width: 1.5,
                              ),
                            ),
                            hintText: "App Name",
                            label: Text("App Name"),
                            prefixIcon: Icon(Iconsax.user)),
                      ),
                      SizedBox(
                        height: fSizes.spaceBtwInputFields,
                      ),

                      // Email And Phone
                      Row(children: [
                        Expanded(
                            child: TextFormField(
                          controller: controller.taxController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                  // Border color when enabled
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                // Border when not focused
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                  // Border color when enabled
                                  width: 1.5,
                                ),
                              ),
                              hintText: "Tax %",
                              label: Text("Tax Rate (%)"),
                              prefixIcon: Icon(Iconsax.tag)),
                        )),
                        const SizedBox(
                          width: fSizes.spaceBtwItems,
                        ),
                        Expanded(
                            child: TextFormField(
                                controller: controller.shippingController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black12,
                                        // Border color when enabled
                                        width: 1.5,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      // Border when not focused
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black12,
                                        // Border color when enabled
                                        width: 1.5,
                                      ),
                                    ),
                                    hintText: "Shipping Cost",
                                    label: Text("Shipping Cost (\$)"),
                                    prefixIcon: Icon(Iconsax.ship)))),
                        const SizedBox(
                          width: fSizes.spaceBtwItems,
                        ),
                        Expanded(
                            flex: 1,
                            child: TextFormField(
                                controller:
                                    controller.freeShippingThresholdController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black12,
                                        // Border color when enabled
                                        width: 1.5,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      // Border when not focused
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black12,
                                        // Border color when enabled
                                        width: 1.5,
                                      ),
                                    ),
                                    hintText: "Free Shipping After (\$)",
                                    label: Text("Free Shipping Threshold (\$)"),
                                    prefixIcon: Icon(Iconsax.ship)))),
                      ]),
                      SizedBox(
                        height: fSizes.spaceBtwInputFields * 2,
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: Obx(
                          () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: Colors.white),
                                  backgroundColor: fColors.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () => controller.loading.value
                                  ? () {}
                                  : controller.updateSettingsInformation(),
                              child: controller.loading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 2)
                                  : Text(
                                      "Update App Settings",
                                      style: TextStyle(color: Colors.white),
                                    )),
                        ),
                      )
                    ])))
      ],
    );
  }
}
