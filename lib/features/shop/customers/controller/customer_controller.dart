import 'package:favour_adminpanel/data/abstract/base_data_table_controller.dart';
import 'package:favour_adminpanel/data/repositories/user/user_repository.dart';
import 'package:favour_adminpanel/features_authentication/models/user_model.dart';
import 'package:get/get.dart';

class CustomerController extends fBaseController<UserModel> {
  static CustomerController get instance => Get.find();

  final _customRepository = Get.put(UserRepository());

  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(UserModel item) async {
    await _customRepository.deleteUser(item.id ?? "");
  }
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (UserModel o) => o.fullName.toString().toLowerCase());
  }
  @override
  Future<List<UserModel>> fetchItems() async  {
    return await _customRepository.getAllUsers();
  }
}