import 'package:flutter/material.dart';

class MenuItems {
  String text;
  IconData icon;
  VoidCallback onPressed;
  MenuItems({
    required this.text,
    required this.icon,
    required this.onPressed,
  });
}
