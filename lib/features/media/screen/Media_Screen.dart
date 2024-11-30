import 'package:favour_adminpanel/common/widgets/layouts/templates/side_layout.dart';
import 'package:flutter/material.dart';

import '../responsive_media/mediaDesktopScreen.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return const fSiteTemplate(desktop: Mediadesktopscreen(),);
  }
}
