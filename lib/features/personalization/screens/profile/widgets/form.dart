import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/features_authentication/controllers/user_controller.dart';
import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilis/constants/colors.dart';
import '../../../../../utilis/constants/sizes.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    controller.firstNameController.text = controller.user.value.firstName;
    controller.lastNameController.text = controller.user.value.lastName;
    controller.phoneController.text = controller.user.value.phoneNumber;
    return Column(
      children: [
        fRoundedContainer(
          padding: const EdgeInsets.symmetric(
              vertical: fSizes.lg, horizontal: fSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile Details",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: fSizes.spaceBtwSections,
              ),

              // First and Last Name
              Form(
                key: controller.formKey,
                  child: Column(
                children: [
                  Row(
                    children: [
                      // First Name
                      Expanded(
                          child: TextFormField(
                            controller: controller.firstNameController,
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
                          hintText: "First Name",
                          label: Text("First Name"),
                          prefixIcon: Icon(Iconsax.user),
                        ),
                        validator: (value) =>
                            fValidator.validateEmptyText("First Name", value),
                      )),
                      const SizedBox(
                        width: fSizes.spaceBtwInputFields,
                      ),
                      // Last Name
                      Expanded(
                          child: TextFormField(
                            controller: controller.lastNameController,
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
                          hintText: "Last Name",
                          label: Text("Last Name"),
                          prefixIcon: Icon(Iconsax.user),
                        ),
                        validator: (value) =>
                            fValidator.validateEmptyText("Last Name", value),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: fSizes.spaceBtwInputFields,
                  ),

                  // Email And Phone
                  Row(
                    children: [
                      // First Name
                      Expanded(
                          child: TextFormField(
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
                            hintText: "Email",
                            label: Text("Email"),
                            prefixIcon: Icon(Iconsax.forward),
                            enabled: true),
                            initialValue: UserController.instance.user.value.email,
                      )),
                      const SizedBox(
                        width: fSizes.spaceBtwItems,
                      ),
                      // Last Name
                      Expanded(
                          child: TextFormField(
                            controller: controller.phoneController,
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
                            hintText: "Phone Number",
                            label: Text("Phone Number"),
                            prefixIcon: Icon(Iconsax.mobile)),
                        validator: (value) =>
                            fValidator.validateEmptyText("Phone Number", value),
                      ))
                    ],
                  )
                ],
              )),
              const SizedBox(
                height: fSizes.spaceBtwSections,
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
                      onPressed: () => controller.loading.value ? () {} :
                      controller.updateUserInformation(),
                      child: controller.loading.value ?
                          const CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)
                   : const Text(
                        "Update Profile",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
