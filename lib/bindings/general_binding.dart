import 'package:favour_adminpanel/common/widgets/manager/network_manager.dart';
import 'package:favour_adminpanel/features_authentication/controllers/user_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    /// -- Core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }
}