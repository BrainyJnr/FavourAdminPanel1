import 'package:favour_adminpanel/features_authentication/widget/login_form.dart';
import 'package:favour_adminpanel/features_authentication/widget/login_header.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';

class LoginMobile extends StatelessWidget {
  const LoginMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height, // Ensures it takes full screen height
          ),
          child: Padding(
            padding: EdgeInsets.all(fSizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically
              crossAxisAlignment: CrossAxisAlignment.start, // Adjust alignment if necessary
              children: [
                // Header
                fLoginHeader(),

                const SizedBox(height: 16), // Add spacing between header and form

                // Form
                fLoginForm(),
              ],
            ),
          ),
        ),
    );
  }
}
