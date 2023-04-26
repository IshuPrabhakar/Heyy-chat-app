import 'package:flutter/material.dart';

import '../theme.dart';

class CustomBorderedButton extends StatelessWidget {
  const CustomBorderedButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.radius = 22.0,
  });

  final double radius;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return CircleAvatar(
      radius: radius,
      backgroundColor: brightness == Brightness.light
          ? AppColors.customIconButtonBackgroundLight
          : AppColors.customIconButtonBackgroundDark,
      child: IconButton(
        alignment: Alignment.center,
        splashRadius: radius,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
          size: radius + 3,
        ),
      ),
    );
  }
}
