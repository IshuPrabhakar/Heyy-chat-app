import 'package:flutter/material.dart';

class MessageReaction extends StatelessWidget {
  const MessageReaction({super.key});

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
              height: 40,
            ),
            Center(child: Text("Todo..")),
          ],
        ),
      ),
    );
  }
}
