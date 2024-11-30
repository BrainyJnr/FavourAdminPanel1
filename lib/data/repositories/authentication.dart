import 'package:favour_adminpanel/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../features_authentication/screens/login/login.dart';
import '../../utilis/exceptors/firebase_auth_exceptors.dart';
import '../../utilis/exceptors/firebase_exceptors.dart';
import '../../utilis/exceptors/format_exception.dart';
import '../../utilis/exceptors/platform_exception.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Firebase Auth Instance
  final _auth = FirebaseAuth.instance;

  //Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  //Get IsAuthenticated User
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  void onReady() {
    _auth.setPersistence(Persistence.LOCAL);
  }

  //Function to determine the relevant screen and redirect accordinly
  void screenRedirect() async {
    final user = _auth.currentUser;

    //If the user is Logged in
    if(user != null) {
      //Navigate to the Home
      Get.offAllNamed(fRoutes.dashboard);
    } else {
      Get.offAllNamed(fRoutes.login);
    }
  }

  /// [EmailAuthentication] - LOGIN
  Future<UserCredential> loginWithEmailAndPassword(String email,
      String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw fFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(String email,
      String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw fFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }


  /// [LogoutUser] - Valid for any authentication.
  Future<void> logout() async {
    try {
     // await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw fFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw fFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw fFormatException();
    } on PlatformException catch (e) {
      throw fPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}
