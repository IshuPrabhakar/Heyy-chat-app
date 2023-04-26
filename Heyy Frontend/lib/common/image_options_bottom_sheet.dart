import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'bordered_button.dart';

class ImageSelectOptions extends StatelessWidget {
  const ImageSelectOptions({super.key, required this.onTap});
  final Function(ImageSource source) onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      height: 200,
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
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
          Expanded(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    leading: CustomBorderedButton(
                      icon: Icons.photo,
                      radius: 25,
                    ),
                    title: Text(
                      "Gallery",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () => onTap(ImageSource.gallery),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    leading: CustomBorderedButton(
                      icon: Icons.camera_alt,
                      radius: 25,
                    ),
                    title: Text(
                      "Camera",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () => onTap(ImageSource.camera),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
