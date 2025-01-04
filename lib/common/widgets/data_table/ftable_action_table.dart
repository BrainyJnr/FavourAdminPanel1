import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utilis/constants/colors.dart';

class fTableActionButton extends StatelessWidget {
  const fTableActionButton(
      {super.key,
       this.view = false,
       this.edit = true,
       this.delete = true,
      this.onViewPressed,
      this.onEditPressed,
      this.onDeletePressed});

  final bool view;
  final bool edit;
  final bool delete;
  final VoidCallback? onViewPressed;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (view)
          IconButton(
              onPressed: onViewPressed,
              icon: Icon(
                Iconsax.eye,
                color: fColors.darkerGrey,
              )),
        if (edit)
          IconButton(
              onPressed: onEditPressed,
              icon: Icon(
                Iconsax.pen_add,
                color: fColors.primary,
              )),
        if (delete)
          IconButton(
              onPressed: onDeletePressed,
              icon: Icon(
                Iconsax.trash,
                color: fColors.darkerGrey,
              )),
      ],
    );
  }
}
