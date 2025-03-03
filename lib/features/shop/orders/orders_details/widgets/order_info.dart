import 'package:favour_adminpanel/app.dart';
import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/shimmers/shimmer.dart';
import 'package:favour_adminpanel/features/shop/orders/controller/order_controller.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:favour_adminpanel/utilis/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/order_model.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo ({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    controller.orderStatus.value = order.status;
    return fRoundedContainer(
      padding: EdgeInsets.all(fSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order Information",style: Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: fSizes.spaceBtwSections,),
          Row(
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Date"),
                  Text(order.formattedOrderDate,style: Theme.of(context).textTheme.bodyMedium,),
                ],
              )),

              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Items"),
                  Text('${order.items.length} Items',style: Theme.of(context).textTheme.bodyMedium,),
                ],
              )),

              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Items"),
                  Text('${order.items.length} Items',style: Theme.of(context).textTheme.bodyMedium,),
                ],
              )),

              Expanded(
                  flex: fDeviceUtilis.isMobileScreen(context) ? 2 : 1,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Status"),
                  Obx(
                    () {
                        if (controller.statusLoader.value)
                          return const fShimmerEffect(
                              width: double.infinity, height: 55);

                        return fRoundedContainer
                          (
                            radius: fSizes.cardRadiusSm,
                            padding: const EdgeInsets.symmetric(
                                horizontal: fSizes.sm, vertical: 0),
                            backgroundColor: fHelperFunctions
                                .getOrderStatusColor(order.status).withOpacity(
                                0.1),
                            child: DropdownButton<OrderStatus>(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0),
                                value: controller.orderStatus.value,
                                onChanged: (OrderStatus? newValue) {
                                  if (newValue != null) {
                                    controller.updateOrderStatus(
                                        order, newValue);
                                  }
                                },
                                items: OrderStatus.values.map((
                                    OrderStatus status) {
                                  return DropdownMenuItem<OrderStatus>(
                                    value: status,
                                    child: Text(
                                      status.name.capitalize.toString(),
                                      style: TextStyle(color: fHelperFunctions
                                          .getOrderStatusColor(order.status)),),
                                  );
                                }).toList()
                            )
                        );
                      }   )
                ],
              )),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total"),
                  Text('\$${order.totalAmount}',style: Theme.of(context).textTheme.bodyMedium,),
                ],
              )),


            ],
          )
        ],
      ),
    );
  }
}
