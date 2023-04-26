import 'package:flutter/material.dart';

class HomePagePopUpMenu extends StatelessWidget {
  const HomePagePopUpMenu({super.key, required this.items, this.icon});

  final List<PopupMenuEntry> items;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (((context) => items)),
      offset: Offset(-15, 40),
      splashRadius: 18,
      elevation: 8,
      icon: icon,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      onSelected: (value) {
        if (value == "profile") {
          //Navigator.of(context).push(UserProfile.route());
        }
      },
    );
  }
}

