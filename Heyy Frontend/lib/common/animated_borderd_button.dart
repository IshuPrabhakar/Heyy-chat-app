import 'package:flutter/material.dart';

import '../theme.dart';

class AnimatedCustomBorderedButton extends StatefulWidget {
  const AnimatedCustomBorderedButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.radius = 22.0,
  });

  final double radius;
  final AnimatedIconData icon;
  final VoidCallback onPressed;

  @override
  State<AnimatedCustomBorderedButton> createState() =>
      _AnimatedCustomBorderedButtonState();
}

class _AnimatedCustomBorderedButtonState
    extends State<AnimatedCustomBorderedButton> with TickerProviderStateMixin {
  bool isPressed = false;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: brightness == Brightness.light
          ? AppColors.customIconButtonBackgroundLight
          : AppColors.customIconButtonBackgroundDark,
      child: IconButton(
        alignment: Alignment.center,
        splashRadius: widget.radius,
        onPressed: () {
          if (!isPressed) {
            _controller.forward();
            isPressed = !isPressed;
            widget.onPressed;
          } else {
            _controller.reverse();
            isPressed = !isPressed;
          }
        },
        icon: AnimatedIcon(
          icon: widget.icon,
          progress: _controller,
          color: Theme.of(context).iconTheme.color,
          size: widget.radius + 3,
        ),
      ),
    );
  }
}
