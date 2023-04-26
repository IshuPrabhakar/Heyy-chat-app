

import 'package:flutter/material.dart';
import 'package:social/theme.dart';

class RoundRectanlgeButton extends StatelessWidget {
  const RoundRectanlgeButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.elevation,
    this.radius,
    this.backgroundColor,
    this.color,
    this.fontSize,
    this.icon,
    this.isLeadingIocn,
  });

  final bool? isLeadingIocn;
  final IconData? icon;
  final double? fontSize;
  final Color? color;
  final Color? backgroundColor;
  final double? radius;
  final double? elevation;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(elevation ?? 5),
        foregroundColor:
            MaterialStateProperty.all<Color>(color ?? AppColors.textLight),
        backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor ?? AppColors.secondary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 26.0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isLeadingIocn ?? false)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                icon,
                size: 16 * 2 - 5,
              ),
            ),
          Text(
            text,
            style: TextStyle(fontSize: fontSize ?? 16),
          ),
        ],
      ),
    );
  }
}
