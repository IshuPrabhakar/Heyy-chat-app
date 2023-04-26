import 'package:flutter/material.dart';

class PopupMenuWidget<T> extends PopupMenuEntry<T> {
  const PopupMenuWidget({
    Key? key,
    required this.height,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  final double height;

  @override
  PopupMenuWidgetState createState() => PopupMenuWidgetState();

  @override
  bool represents(T? value) => true;
}

class PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) => widget.child;
}