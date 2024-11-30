import 'package:flutter/material.dart';

class fAppTheme {
  fAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
   // textTheme: fTextTheme.lightTextTheme,
    //     chipTheme: fChipTheme.lightChipTheme,
    //     scaffoldBackgroundColor: Colors.white,
    //     appBarTheme: fAppBarTheme.lightAppBarTheme,
    //     checkboxTheme: fCheckboxTheme.lightCheckboxTheme,
    //     bottomSheetTheme: fButtomSheetTheme.lightButtomSheetTheme,
    //     elevatedButtonTheme: fElevatedButtonTheme.lightElevatedButtonTheme,
    //     outlinedButtonTheme: fOutlinedButtonTheme.lightOutlineButtonTheme,
    //     inputDecorationTheme: fTextFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
   // textTheme: fTextTheme.darkTextTheme,
    //     chipTheme: fChipTheme.darkChipTheme,
    //     appBarTheme: fAppBarTheme.darkAppBarTheme,
    //     checkboxTheme: fCheckboxTheme.darkCheckboxTheme,
    //     bottomSheetTheme: fButtomSheetTheme.darkButtomSheetTheme,
    //     elevatedButtonTheme: fElevatedButtonTheme.darkElevatedButtonTheme,
    //     outlinedButtonTheme: fOutlinedButtonTheme.darkOutlineButtonTheme,
    //     inputDecorationTheme: fTextFieldTheme.darkInputDecorationTheme,
  );
}