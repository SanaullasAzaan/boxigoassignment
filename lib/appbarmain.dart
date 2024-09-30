import 'package:flutter/material.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMain({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:Colors.grey,
      toolbarHeight:10.0, // Set a smaller toolbar height (e.g., 40.0)
    );
  }

  // Set the preferredSize to a custom height
  @override
  Size get preferredSize => const Size.fromHeight(10.0);
}
