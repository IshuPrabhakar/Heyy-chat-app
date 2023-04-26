import 'dart:io';

import 'package:flutter/material.dart';

import '../../../common/utils.dart';
import '../../../screens/contact_profile/contact_profile.dart';
import '../../../screens/qr_scanner/qr_view.dart';
import '../../../theme.dart';
import '../../../common/bordered_button.dart';

class ViewContactBottomSheet extends StatelessWidget {
  const ViewContactBottomSheet({super.key, this.image});

  final File? image;
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
            // Profile photo
            InkWell(
              borderRadius: BorderRadius.circular(65),
              onTap: () {
                Navigator.of(context).push(
                  ContactProfile.route(),
                );
              },
              child: image == null
                  ? CircleAvatar(
                      backgroundColor: brightness == Brightness.light
                          ? Colors.grey.shade100
                          : AppColors.cardDark,
                      radius: 50,
                      child: Icon(
                        Icons.account_circle,
                        size: 100,
                        color: Colors.blue.shade600,
                      ), // Replace with lottie animation
                    )
                  : CircleAvatar(
                      backgroundImage: FileImage(image!),
                      radius: 65,
                    ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              "Rohit Sharma",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              "Profession will be here",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            // action buttons
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomBorderedButton(
                    radius: 26,
                    icon: Icons.phone,
                    onPressed: () {},
                  ),
                  CustomBorderedButton(
                    radius: 26,
                    icon: Icons.message,
                    onPressed: () {},
                  ),
                  CustomBorderedButton(
                    radius: 26,
                    icon: Icons.video_call,
                    onPressed: () {},
                  ),
                  CustomBorderedButton(
                    radius: 26,
                    icon: Icons.share,
                    onPressed: () {
                      Navigator.of(context).pop();
                      showCustomBottomSheet(
                        context,
                        QrView(
                          value: "Heyy",
                          name: "Rohit Sharma",
                        ),
                        0.65,
                        .9,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
