import 'package:flutter/material.dart';

import '../main.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
   const MyAppBar({super.key, required this.title, required this.appBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
          IconButton(
              icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                MyApp.themeNotifier.value =
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              })
        ],
    );
  }

 
@override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
