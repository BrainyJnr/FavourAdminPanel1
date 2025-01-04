import 'package:flutter/material.dart';
import '../../../utilis/constants/colors.dart';
import '../../../utilis/helpers/helper_function.dart';
import '../custom_shapes/container/fcircular_container.dart';

class fChoiceChip extends StatelessWidget {
  const fChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = fHelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        // Label for the chip
        label: isColor ? const SizedBox() : Text(text),

        // Selection logic
        selected: selected,
        onSelected: onSelected,

        // Label style (text color)
        labelStyle: TextStyle(
          color: selected ? fColors.white : null,
        ),

        // Avatar or circular icon logic
        avatar: isColor
            ? fCircular_Container(
          width: 50,
          height: 50,
          backgroundColor: fHelperFunctions.getColor(text)!,
        )
            : null,

        // Adjust padding
        labelPadding:
        isColor ? const EdgeInsets.all(0) : const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),

        // Shape for circular chips
        shape: isColor ? const CircleBorder() : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        // Colors for selected and unselected states
        backgroundColor: isColor
            ? fHelperFunctions.getColor(text)!
            : fColors.lightGrey,
        selectedColor: fColors.primary, // Blue color when selected
      ),
    );
  }
}
