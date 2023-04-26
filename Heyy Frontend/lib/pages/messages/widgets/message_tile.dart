import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../common/avatar.dart';
import 'bottom_sheet.dart';
import '../../../models/user.dart';
import '../../../providers/provider.dart';
import '../../../screens/chat/chat_screen.dart';
import '../../../theme.dart';
import '../../../common/utils.dart';

class MessageTitle extends StatelessWidget {
  const MessageTitle({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  // make voice call when the user swipes right
  // to the message tile
  void makeVoiceCall() {}

  // make Video call when the user swipes right
  // to the message tile
  void makeVideoCall() {}

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final popUpOptions = ref.watch(messageTilePopUpOptionsProvider);
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              ChatScreen.route(user),
            );
          },
          onLongPressStart: (details) {
            showHomePagePopUpMenu(
                context, details.globalPosition, popUpOptions,);
          },
          child: SwipeTo(
            offsetDx: .17,
            onLeftSwipe: () => makeVideoCall,
            leftSwipeWidget: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.video_call,
                color: Colors.blue,
              ),
            ),
            onRightSwipe: () => makeVoiceCall(),
            rightSwipeWidget: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                Icons.call,
                color: Colors.blue,
              ),
            ),
            child: Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        child: Avatar.medium(url: user.profilePicture),
                        onTap: () {
                          showCustomBottomSheet(
                            context,
                            ViewContactBottomSheet(),
                            0.45,
                            .45,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              user.name, // Sender name
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                letterSpacing: 0.2,
                                wordSpacing: 1.5,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          // Message
                          // TODO: To implement colored unread messages
                          // TODO: implement message seen status
                          SizedBox(
                            height: 20,
                            child: Text(
                              user.preview!.message,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textFaded,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          // Message date
                          Text(
                            user.preview!.date
                                .toUpperCase(), // TODO: implement to show time if date is today's date
                            style: const TextStyle(
                              fontSize: 11,
                              letterSpacing: -0.2,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textFaded,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // Message count Circle
                          Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                user.preview!.messageCount,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textLight,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
