import 'package:favour_adminpanel/data/repositories/authentication.dart';
import 'package:favour_adminpanel/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class fRoutesMiddleWare extends GetMiddleware {

  @override
  RouteSettings? redirect(String? route) {
    return AuthenticationRepository.instance.isAuthenticated ? null
        : const RouteSettings(name: fRoutes.login);

  }
}