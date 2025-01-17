import 'package:favour_adminpanel/utilis/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utilis/constants/colors.dart';

class TableHeader extends StatelessWidget {
  const TableHeader(
      {super.key,
      this.onPressed,
      this.searchController,
      this.searchChanged,
      this.showLeftWidget = true,
      this.buTTonText = "Add"});

  final Function()? onPressed;
  final TextEditingController? searchController;
  final Function(String)? searchChanged;
  final String buTTonText;
  final bool showLeftWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: fDeviceUtilis.isDesktopScreen(context) ? 3 : 1,
            child: showLeftWidget
                ? Row(children: [
                    SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(color: Colors.white),
                                backgroundColor: fColors.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: onPressed,
                            child: Text(
                              buTTonText,
                              style: TextStyle(color: Colors.white),
                            )))
                  ])
                : const SizedBox.shrink()),
        Expanded(
          flex: fDeviceUtilis.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: searchController,
            onChanged: searchChanged,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black12, // Border color when enabled
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  // Border when not focused
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black12, // Border color when enabled
                    width: 1.5,
                  ),
                ),
                hintText: "Search here...",
                prefixIcon: Icon(Iconsax.search_normal)),
          ),
        )
      ],
    );
  }
}
