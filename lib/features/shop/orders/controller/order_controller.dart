import 'package:favour_adminpanel/common/widgets/loaders/floaders.dart';
import 'package:favour_adminpanel/data/abstract/base_data_table_controller.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:get/get.dart';

import '../model/order_model.dart';
import '../repositroy/order_repository.dart';

class OrderController extends fBaseController<OrderModel> {
 static OrderController get  instance => Get.find();

 RxBool statusLoader = false.obs;
 var orderStatus = OrderStatus.delivered.obs;
 final _orderRepository = Get.put(OrderRepository());

  @override
  bool containsSearchQuery(OrderModel item, String query) {
    // TODO: implement containsSearchQuery
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OrderModel item) async {
    // TODO: implement deleteItem
    await _orderRepository.deleteOrder(item.docId);
  }

 @override
 Future<List<OrderModel>> fetchItems() async {
   sortAscending.value = false;
   final orders = await _orderRepository.getAllOrders();
   print("Fetched Orders: ${orders.length}");
   return orders;
 }


 void sortById(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (OrderModel o) => o.totalAmount.toString().toLowerCase());
 }

 void sortByData(int sortColumnIndex, bool ascending) {
   sortByProperty(sortColumnIndex, ascending, (OrderModel o) => o.totalAmount.toString().toLowerCase());
  }

  Future<void> updateOrderStatus(OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.status = newStatus;
      await _orderRepository.updateOrderSpecificValue(
          order.docId, {'status': newStatus.toString()});
      updateItemFromLists(order);
      orderStatus.value = newStatus;
      fLoaders.successSnackBar(
          title: "Updated", message: "Order Status Updated");
    } catch (e) {
      fLoaders.warningSnackBar(title: "Oh Snap", message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }

}