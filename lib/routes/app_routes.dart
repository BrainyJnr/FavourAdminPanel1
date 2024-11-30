import 'package:favour_adminpanel/features/media/screen/Media_Screen.dart';
import 'package:favour_adminpanel/features_authentication/screens/forget_password/forget_password.dart';
import 'package:favour_adminpanel/features_authentication/screens/reset_password/reset_passsword.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/routes/routes_middlewares.dart';
import 'package:get/get.dart';
import '../features/shop/dashboard/dashboard_screen.dart';
import '../features_authentication/screens/login/login.dart';

class fAppRoute {
  static final List<GetPage> pages = [
    GetPage(name: fRoutes.login, page: () => const LoginScreen()),
    GetPage(name: fRoutes.forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: fRoutes.resetPassword, page: () => const ResetPasssword()),
    GetPage(name: fRoutes.dashboard, page: () => const DashboardScreen(),middlewares: [fRoutesMiddleWare()]),
    GetPage(name: fRoutes.media, page: () => const MediaScreen(),middlewares: [fRoutesMiddleWare()]),
  ];

}

