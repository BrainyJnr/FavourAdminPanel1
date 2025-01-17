import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/styles/frounded_image.dart';
import 'package:favour_adminpanel/features/shop/dashboard/controller/dashboard_controller.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../utilis/constants/image_strings.dart';

class OrderTransaction extends StatelessWidget {
  const OrderTransaction({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return fRoundedContainer(
      padding: EdgeInsets.all(fSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Transaction",style: Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: fSizes.spaceBtwSections,),

          Row(
            children: [
              Expanded(
                  flex: fDeviceUtilis.isMobileScreen(context) ? 2 : 1,
                  child: Row(
                children: [
                  const fRoundedImage(padding: fSizes.chi,imageType: ImageType.asset,image: fImages.Acer,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Payment via ${order.paymentMethod.capitalize}",
                      style: Theme.of(context).textTheme.titleLarge,),
                      Text('${order.paymentMethod.capitalize!} fee \$25',
                    style: Theme.of(context).textTheme.labelMedium,),

                ],
                  ))

                ],
              )),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date",style: Theme.of(context).textTheme.labelMedium,),
                  Text("Nov 3 2025",style: Theme.of(context).textTheme.bodyMedium,),
                ],
              )),

              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total",style: Theme.of(context).textTheme.labelMedium,),
                  Text("\$${order.totalAmount}",style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ))

            ],
          )
        ],
      ),
    );
  }
}
