import 'package:favour_adminpanel/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

import '../../layouts/headers/header.dart';

class DesktopLayout extends StatelessWidget {
  final Widget? body;

  const DesktopLayout({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          const Expanded(
            child: fSidebar(),
          ),
          // Main content
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // Header
                fHeader(),
                // Body content
                Expanded(
                  child: Container(
                    color: Colors.blue[50], // Debug background color
                    child: body ??
                        Center(
                          child: Text(
                            "No content provided",
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
