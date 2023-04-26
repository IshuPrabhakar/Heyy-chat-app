import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrView extends StatelessWidget {
  const QrView({
    super.key,
    required this.value,
    required this.name,
  });

  final String value;
  final String name;
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Column(
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
              height: 50,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: double.maxFinite,
              height: 300,
              child: Center(
                child: PrettyQr(
                  data: value,
                  size: 170,
                  roundEdges: true,
                  image: AssetImage("assets/appicon.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
