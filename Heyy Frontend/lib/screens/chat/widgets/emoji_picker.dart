import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/chat_screen_provider.dart';

class CustomEmojiPicker extends ConsumerWidget {
  const CustomEmojiPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    final controller = ref.read(bottomTextFeildControllerProvider);
    var config2 = Config(
      columns: 7,
      emojiSizeMax: 32 *
          (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
      verticalSpacing: 0,
      horizontalSpacing: 0,
      gridPadding: EdgeInsets.zero,
      initCategory: Category.RECENT,
      bgColor: Theme.of(context).cardColor,
      indicatorColor: Colors.blue,
      iconColor: Colors.grey,
      iconColorSelected: Colors.blue,
      backspaceColor: Colors.blue,
      skinToneDialogBgColor: Colors.white,
      skinToneIndicatorColor: Colors.grey,
      enableSkinTones: true,
      showRecentsTab: true,
      recentsLimit: 28,
      noRecents: const Text(
        'No Recents',
        style: TextStyle(fontSize: 20, color: Colors.black26),
        textAlign: TextAlign.center,
      ), // Needs to be const Widget
      loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
      tabIndicatorAnimDuration: kTabScrollDuration,
      categoryIcons: const CategoryIcons(),
      buttonMode: ButtonMode.MATERIAL,
    );
    return Column(
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
          height: 10,
        ),
        SizedBox(
          height: 320,
          child: EmojiPicker(
            onEmojiSelected: (category, emoji) {
              // Do something when emoji is tapped (optional)
            },
            onBackspacePressed: () {
              // Do something when the user taps the backspace button (optional)
              // Set it to null to hide the Backspace-Button
            },
            textEditingController: controller,
            config: config2,
          ),
        ),
      ],
    );
  }
}
