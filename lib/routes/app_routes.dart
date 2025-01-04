import 'package:favour_adminpanel/features/media/screen/Media_Screen.dart';
import 'package:favour_adminpanel/features/shop/brands/createbrands/screens/createbrands.dart';
import 'package:favour_adminpanel/features/shop/categories/create_category/create_categoryscreen.dart';
import 'package:favour_adminpanel/features/shop/categories/edit_category/edit_categoryscreen.dart';
import 'package:favour_adminpanel/features/shop/categories/screens/category_screen.dart';
import 'package:favour_adminpanel/features/shop/products/screens/product_screen.dart';
import 'package:favour_adminpanel/features_authentication/screens/forget_password/forget_password.dart';
import 'package:favour_adminpanel/features_authentication/screens/reset_password/reset_passsword.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:favour_adminpanel/routes/routes_middlewares.dart';
import 'package:get/get.dart';
import '../features/shop/banners/allbanners/screens/banners_screen.dart';
import '../features/shop/banners/create_banners/screens/createbannerScreen.dart';
import '../features/shop/banners/edit_banners/screens/edit_banner_screens.dart';
import '../features/shop/brands/allbrands/screens/brandscreens.dart';
import '../features/shop/brands/editbrand/screens/editbrands.dart';
import '../features/shop/dashboard/dashboard_screen.dart';
import '../features/shop/products/create_products/screens/create_product_screen.dart';
import '../features/shop/products/edit_products/screens/edit_product_screen.dart';
import '../features_authentication/screens/login/login.dart';

class fAppRoute {
  static final List<GetPage> pages = [
    GetPage(name: fRoutes.login, page: () => const LoginScreen()),
    GetPage(name: fRoutes.forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: fRoutes.resetPassword, page: () => const ResetPasssword()),
    GetPage(name: fRoutes.dashboard, page: () => const DashboardScreen(),middlewares: [fRoutesMiddleWare()]),
    GetPage(name: fRoutes.media, page: () => const MediaScreen(),middlewares: [fRoutesMiddleWare()]),

    GetPage(name: fRoutes.categories, page: () => const CategoryScreen(),middlewares: [fRoutesMiddleWare()]),
    GetPage(name: fRoutes.createCategory, page: () => const CreateCategoryscreen(),middlewares: [fRoutesMiddleWare()]),
    GetPage(name: fRoutes.editCategory, page: () => const EditCategoryscreen(),middlewares: [fRoutesMiddleWare()]),

    GetPage(name: fRoutes.brands, page: () => const Brandscreens(),middlewares: [fRoutesMiddleWare()]),
    GetPage(name: fRoutes.createBrand, page: () => const CreateBrands(),middlewares: [fRoutesMiddleWare()]),
    GetPage(name: fRoutes.editBrand, page: () => const Editbrands(),middlewares: [fRoutesMiddleWare()]),

    GetPage(name: fRoutes.banners, page: () => const BannersScreen(),middlewares: [fRoutesMiddleWare()]),
    GetPage(name: fRoutes.createBanner, page: () => const Createbannerscreen(),middlewares: [fRoutesMiddleWare()]),
    GetPage(name: fRoutes.editBanner, page: () => const EditBannerScreens(),middlewares: [fRoutesMiddleWare()]),

    GetPage(name: fRoutes.products, page: () => const ProductScreen(),middlewares: [fRoutesMiddleWare()]),
    GetPage(name: fRoutes.createProduct, page: () => const CreateProductScreen(),middlewares: [fRoutesMiddleWare()]),
    GetPage(name: fRoutes.editProduct, page: () => const EditProductScreen(),middlewares: [fRoutesMiddleWare()]),




  ];

}

