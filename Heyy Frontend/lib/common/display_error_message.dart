import 'package:flutter/material.dart';

class DisplayErrorMessage extends StatelessWidget {
  const DisplayErrorMessage({Key? key, this.error}) : super(key: key);

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Oh no, something went wrong. '
        'Please check your config. $error',
      ),
    );
  }
}