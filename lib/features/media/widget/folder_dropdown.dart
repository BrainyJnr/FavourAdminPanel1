import 'package:favour_adminpanel/features/media/controller/media_controller.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaFolderDropdown extends StatelessWidget {
  const MediaFolderDropdown({super.key, this.onChanged});

  final void Function(MediaCategory?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
          () => SizedBox(
        width: 140,
        child: DropdownButtonFormField<MediaCategory>(
          isExpanded: false,
          value: controller.selectedPath.value,
          items: MediaCategory.values
              .map(
                (category) => DropdownMenuItem<MediaCategory>(
              value: category,
              child: Text(
                category.name.capitalize.toString(),
              ),
            ),
          )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Optional: Add rounded corners
              borderSide: BorderSide(color: Colors.black), // Remove the border
            ),
          ),
          style: TextStyle(
            color: Colors.black, // Text color
            fontSize: 14, // Optional: Adjust font size
          ),
        ),
      ),
    );
  }
}