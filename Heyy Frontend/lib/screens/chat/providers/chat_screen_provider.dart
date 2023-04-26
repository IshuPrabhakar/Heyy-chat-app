import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomTextFeildControllerProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
);
