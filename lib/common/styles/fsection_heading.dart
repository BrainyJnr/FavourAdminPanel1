import 'package:flutter/material.dart';

class fSectionHeading extends StatelessWidget {
  const fSectionHeading({
    super.key,
    // this.textColor,

    required this.title,
    this.rightSideWidget,
    this.textColor,
  });

  //final Color? textColor;
  final Color? textColor;
  final Widget? rightSideWidget;
  final String title;
  //final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return
      // Padding(
      //padding: const EdgeInsets.only(right: 155,top: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          if (rightSideWidget!= null) rightSideWidget!
        ],

      );
  }
}

class fSectionHeadings extends StatelessWidget {
  const fSectionHeadings({
    super.key,
    // this.textColor,

    required this.title,
    this.rightSideWidget,
    this.textColor,
  });

  //final Color? textColor;
  final Color? textColor;
  final Widget? rightSideWidget;
  final String title;
  //final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return
      // Padding(
      //padding: const EdgeInsets.only(right: 155,top: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          if (rightSideWidget!= null) rightSideWidget!
        ],

      );
  }
}
