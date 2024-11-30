import 'package:favour_adminpanel/common/widgets/loaders/ffull_screenloader.dart';
import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/common/widgets/manager/network_manager.dart';
import 'package:favour_adminpanel/data/repositories/authentication.dart';
import 'package:favour_adminpanel/data/repositories/user/user_repository.dart';
import 'package:favour_adminpanel/features_authentication/controllers/user_controller.dart';
import 'package:favour_adminpanel/features_authentication/models/user_model.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Variables
  RxBool rememberMe = false.obs; // Use RxBool, not RxString
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  //final userController = Get.put(UserController());


  @override
  void onInit() {
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? "";
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? "";
    super.onInit();
  }

  /// Handles email and password sign-in process
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      fFullScreenLoader.openLoadingDialog(
        "Logging you in...", fImages.Animation1,);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        fFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
    if(!loginFormKey.currentState!.validate()){
      fFullScreenLoader.stopLoading();
      return;
    }

    // Save Data if Remember Me is Selected
      if(rememberMe.value){
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      }

      await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Fetch user details and assign to UserController
      final user = await UserController.instance.fetchUserDetails();

      // Remove Loader
      fFullScreenLoader.stopLoading();

      // if user is not admin, logout and return
      if(user.role != AppRole.admin){
        await AuthenticationRepository.instance.logout();
        fLoaders.errorSnackBar(title: "Not Authorized", message: "You are not authorized. Contact Admin");

      } else {
        // Redirect
        AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      fFullScreenLoader.stopLoading();
      fLoaders.errorSnackBar(title: "Oh Snap", message:  e.toString());
    }

  }

  /// Handles registration of admin user
  Future<void> registerAdmin() async {
    try{
      // Start Loading
      fFullScreenLoader.openLoadingDialog(
        "Registering Admin Account...", fImages.Animation1,);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        fFullScreenLoader.stopLoading();
      }

      // Register user using Email & Password Authentication
      await AuthenticationRepository.instance.registerWithEmailAndPassword(
          "sgodwinchimdikefavour@gmail.com", "Chimdike");

      // Create admin record in the Firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
          UserModel(
              id: AuthenticationRepository.instance.authUser!.uid,
              firstName: "Godwin",
              lastName: "Chimdike",
              email: "sgodwinchimdikefavour@gmail.com",
              role: AppRole.admin,
              createAt: DateTime.now())
      );

      // Remove Loader
      fFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      fFullScreenLoader.stopLoading();
      fLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());

    }

  }
}