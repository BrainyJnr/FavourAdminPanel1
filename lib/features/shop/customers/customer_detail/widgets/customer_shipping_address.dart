import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/common/widgets/loaders/fanimation.dart';
import 'package:favour_adminpanel/features/shop/address/address_model.dart';
import 'package:favour_adminpanel/features/shop/customers/customer_detail/controller/customer_detail_controller.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerAddresses();
    return Obx(
      () {
        if(controller.addressLoading.value) return const fLoaderAnimation();

        AddressModel selectAddress = AddressModel.empty();
        if(controller.customer.value.addresses != null) {
          if(controller.customer.value.addresses!.isNotEmpty) {
            selectAddress = controller.customer.value.addresses!.where((element) => element.selectedAddress).single;
          }
        }


       return   fRoundedContainer(
          padding: const EdgeInsets.all(fSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Address",style: Theme.of(context).textTheme.headlineSmall,),
              SizedBox(height: fSizes.spaceBtwSections,),

              // Meta Data
              Row(
                children: [
                  const SizedBox(width: 120,child: Text("Name"),),
                  Text(":"),
                  SizedBox(width: fSizes.spaceBtwItems / 2,),
                  Expanded(child: Text(selectAddress.name,style: Theme.of(context).textTheme.titleSmall,)),
                ],
              ),
              SizedBox(height: fSizes.spaceBtwItems / 2,),
              Row(
                children: [
                  SizedBox(width: 120,child: Text("Country"),),
                  Text(":"),
                  Expanded(child: Text(selectAddress.country,style: Theme.of(context).textTheme.titleSmall,)),
                ],
              ),
              SizedBox(height: fSizes.spaceBtwItems / 2,),
              Row(
                  children: [
                    SizedBox(width: 120,child: Text("Phone Number"),),
                    Text(":"),
                    Expanded(child: Text(selectAddress.phoneNumber,style: Theme.of(context).textTheme.titleSmall,)),]),

              SizedBox(height: fSizes.spaceBtwItems / 2,),
              Row(
                  children: [
                    SizedBox(width: 120,child: Text("Address"),),
                    Text(":"),
                    Expanded(child: Text(selectAddress.id.isNotEmpty ? selectAddress.toString() : "",style: Theme.of(context).textTheme.titleSmall,)),
                  ]) ],
          ),
        );
      },
    );
  }
}
