import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      height: 400,
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          left: 15,
          right: 15,
          bottom: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 50,
                color: brightness == Brightness.light
                    ? Colors.grey.shade300
                    : Colors.grey.shade200,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                child: Lottie.asset(
                  "assets/something_went_wrong.json",
                  height: 250,
                  width: 320,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
