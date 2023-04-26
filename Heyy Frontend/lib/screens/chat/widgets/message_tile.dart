import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social/screens/chat/constants/constants.dart';
import 'package:social/screens/chat/widgets/emoji_picker.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../common/popup_menu.dart';
import '../../../theme.dart';
import '../../../common/common.dart';
import '../../profile/profile_screen.dart';
import 'message_info.dart';
import 'message_reaction.dart';

// Chat message tiles
class MessageTile extends ConsumerStatefulWidget {
  const MessageTile({
    Key? key,
    required this.message,
    required this.messageDate,
    required this.isSender,
    required this.status,
    required this.type,
    this.onSwipe,
    this.onDeleteAction,
    this.onForwardAction,
    this.isReacted = false,
    this.reactions,
  }) : super(key: key);

  final String message;
  final String messageDate;
  final bool isSender;
  final String status;
  final MessageType type;
  final bool isReacted;
  final List<Text>? reactions;
  final Function()? onSwipe;
  final Function()? onDeleteAction;
  final Function()? onForwardAction;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageTileState();
}

late BuildContext bottomSheetContext;

class _MessageTileState extends ConsumerState<MessageTile>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    bottomSheetContext = context;

    _animationController = AnimationController(
      duration: Duration(milliseconds: 30),
      vsync: this,
      lowerBound: 0,
      upperBound: 0.02,
    )..addListener(
        () {
          setState(() {});
        },
      );
    ;
  }

  List<PopupMenuEntry> messageTileOptions = [
    PopupMenuWidget(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _reactWidget(
            Reactions.Heart,
            () {},
          ),
          _reactWidget(
            Reactions.Wow,
            () {},
          ),
          _reactWidget(
            Reactions.Like,
            () {},
          ),
          _reactWidget(
            Reactions.Angry,
            () {},
          ),
          _reactWidget(
            Reactions.Sad,
            () {},
          ),
          // more button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 3,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                showCustomBottomSheet(
                    bottomSheetContext, CustomEmojiPicker(), .4, .6);
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    ),
    _menuItem("Reply"),
    _menuItem("Forward"),
    _menuItem("Info"),
    _menuItem("Delete"),
  ];

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Message tile onTapUp
  void onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  // Message tile onTapDown
  void onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  // Message tile onTap
  void onTapCancel() {
    _animationController.reverse();
  }

  // on message tile swipe usually for reply
  void onSwipe() {
    widget.onSwipe;
  }

  // react on double tap
  void onDoubleTap() {
    // TODO: default reaction on double tap
  }

  // Message tile popup options
  void showMessageTilePopUpMenu(BuildContext context, Offset offset,
      List<PopupMenuEntry<dynamic>> items) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromDirectional(
          textDirection: Directionality.of(context),
          start: left,
          top: top,
          end: left + 2,
          bottom: top + 2),
      items: items,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    ).then((value) {
      switch (value) {
        case 'Info':
          showCustomBottomSheet(
            bottomSheetContext,
            MessageInfo(),
            .18,
            .18,
          );
          break;
        case 'Delete':
          // have to implement
          break;
        case 'Forward':
          // have to implement
          break;
        case 'Reply':
          onSwipe();
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    // message tile pop animation
    double scale1 = 1 + _animationController.value;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: widget.isSender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              //profile image avatar
              if (!widget.isSender)
                InkWell(
                  child: Avatar(
                    radius: 15,
                    url:
                        "https://fsb.zobj.net/crop.php?r=FAcicNvLZvREd2P2K5zZ9L0JIRulV8TzAV5foNxUVRxrsoW0wh3DgQIozJv0HSgWCILHwsKEwVb865BLg-L9RKoE96jm-7VwmGTAwdmjbEgLZ1TTzZmX-5RfzkY2LYrpQj8ArPyITHBy0-abcIOq3hQ8yhEJBVpdeUT_tDOShgQVAuuKvlBjqVJj9Y7-Gk6rcT3kOY0zyR2NwKVL",
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      UserProfile.route(),
                    );
                  },
                ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTapUp: onTapUp,
                onTapDown: onTapDown,
                onTapCancel: onTapCancel,
                onDoubleTap: onDoubleTap,
                onLongPressStart: (details) {
                  showMessageTilePopUpMenu(
                      context, details.globalPosition, messageTileOptions);
                },
                child: Transform.scale(
                  scale: scale1,
                  child: SwipeTo(
                    onRightSwipe: !widget.isSender ? onSwipe : null,
                    onLeftSwipe: widget.isSender ? onSwipe : null,
                    offsetDx: .17,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: widget.isSender
                                ? AppColors.secondary
                                : (brightness == Brightness.light)
                                    ? AppColors.cardLight
                                    : AppColors.cardDark,
                            borderRadius: BorderRadius.circular(
                              26.0,
                            ),
                          ),
                          constraints: BoxConstraints(
                            maxWidth: 250,
                            maxHeight: 500,
                            minWidth: 50,
                            minHeight: 40,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 20,
                            ),
                            // Message
                            child: (widget.type == MessageType.Text)
                                ? Text(
                                    widget.message,
                                    style: TextStyle(
                                      color: widget.isSender
                                          ? AppColors.textLight
                                          : (brightness == Brightness.light)
                                              ? AppColors.textDark
                                              : AppColors.textLight,
                                    ),
                                  )
                                : Image.network(
                                    "https://fsb.zobj.net/crop.php?r=FAcicNvLZvREd2P2K5zZ9L0JIRulV8TzAV5foNxUVRxrsoW0wh3DgQIozJv0HSgWCILHwsKEwVb865BLg-L9RKoE96jm-7VwmGTAwdmjbEgLZ1TTzZmX-5RfzkY2LYrpQj8ArPyITHBy0-abcIOq3hQ8yhEJBVpdeUT_tDOShgQVAuuKvlBjqVJj9Y7-Gk6rcT3kOY0zyR2NwKVL",
                                    height: 350,
                                    width: 200,
                                  ),
                          ),
                        ),
                        // Reaction widget
                        if (widget.isReacted)
                          Positioned(
                            bottom: 0,
                            right: widget.isSender ? 10 : null,
                            left: widget.isSender ? null : 10,
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: widget.isSender
                                      ? Colors.grey
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 1, horizontal: 2),
                                  child: Row(
                                    // listview builder with horizontal list containig reactions
                                    children: [
                                      Text(Reactions.Heart),
                                      Text(Reactions.Wow),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                showCustomBottomSheet(
                                  bottomSheetContext,
                                  MessageReaction(),
                                  .2,
                                  .2,
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, left: widget.isSender ? 0 : 40),
            child: Row(
              mainAxisAlignment: widget.isSender
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                // Message date
                Text(
                  widget.messageDate,
                  style: TextStyle(
                    color: AppColors.textFaded,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                // Message status
                if (widget.isSender)
                  Text(
                    widget.status,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

PopupMenuItem<dynamic> _menuItem(String text) {
  return PopupMenuItem(
    padding: EdgeInsets.only(
      left: 30,
      bottom: 3,
      top: 5,
      right: 10,
    ),
    child: Text(text),
    value: text,
  );
}

Widget _reactWidget(
  String reaction,
  VoidCallback onPressed,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 3,
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPressed,
      child: Text(
        reaction,
        style: TextStyle(fontSize: 22),
      ),
    ),
  );
}
