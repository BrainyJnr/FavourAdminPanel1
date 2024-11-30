import 'package:favour_adminpanel/features_authentication/controllers/login_controller.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/utilis/validators/fvalidators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../common/widgets/texts/text_strings.dart';
import '../../utilis/constants/colors.dart';
import '../../utilis/constants/sizes.dart';

class fLoginForm extends StatelessWidget {
  const fLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: fSizes.spaceBtwSections),
          child: Column(
            children: [
              /// Email
              TextFormField(
                controller: controller.email,
                validator: fValidator.validateEmail,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black12, // Border color when enabled
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Border when not focused
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black12, // Border color when enabled
                      width: 1.5,
                    ),
                  ),
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: fTexts.email,
                ),
              ),
              const SizedBox(
                height: fSizes.spaceBtwInputFields,
              ),

              /// Password
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  obscureText: controller.hidePassword.value,
                  validator: (value) =>
                      fValidator.validateEmptyText("Password", value),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black12, // Border color when enabled
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      // Border when not focused
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black12, // Border color when enabled
                        width: 1.5,
                      ),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye)),
                    prefixIcon: Icon(Iconsax.password_check),
                    labelText: fTexts.password,
                  ),
                ),
              ),
              const SizedBox(
                height: fSizes.spaceBtwInputFields / 2,
              ),

              ///Remember Me & Forget Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Remember Me
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value)),
                      const Text(fTexts.rememberMe)
                    ],
                  ),

                  /// Forget Password
                  TextButton(
                      onPressed: () => Get.toNamed(fRoutes.forgetPassword),
                      child: const Text(fTexts.forgetpassword))
                ],
              ),
              const SizedBox(
                height: fSizes.spaceBtwSections,
              ),

              /// Sign In Button
              SizedBox(
                width: double.infinity,
                height: 48,
                               child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                         side: BorderSide(color: Colors.white),
                        backgroundColor: fColors.primary,
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10))),
                     onPressed: () => controller.emailAndPasswordSignIn(),
                     child: const Text(
                       fTexts.signIn,
                      style: TextStyle(color: fColors.white),

               // child: OutlinedButton(
    //                     style: ElevatedButton.styleFrom(
    //                         side: BorderSide(color: Colors.white),
    //                         backgroundColor: fColors.primary,
    //                         shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(10))),
    //                     onPressed: () => controller.registerAdmin(),
    //                     child: const Text(
    //                       fTexts.signIn,
    //                       style: TextStyle(color: fColors.white),
    //                     )),
    //               )

                     )))
            ],
          ),
        ));
  }
}
