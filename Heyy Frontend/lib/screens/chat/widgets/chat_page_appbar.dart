import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social/common/avatar.dart';

import '../../../models/models.dart';
import '../../screens.dart';
import 'appbar_popup.dart';

class ChatScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  final User user;
  const ChatScreenAppbar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: (brightness != Brightness.light)
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: (brightness == Brightness.light)
            ? Brightness.light
            : Brightness.dark,
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).cardColor,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            right: 6,
          ),
          child: Row(
            children: <Widget>[
              // Back button
              IconButton(
                splashRadius: 18.0,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              // User profile button
              IconButton(
                padding: const EdgeInsets.all(0),
                splashRadius: 18.0,
                // Open container for opening and closing animations
                icon: OpenContainer(
                  openElevation: 0,
                  closedElevation: 0,
                  openShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  transitionType: ContainerTransitionType.fadeThrough,
                  openBuilder: (BuildContext context,
                          void Function({Object? returnValue}) action) =>
                      UserProfile(),
                  closedBuilder: (context, VoidCallback openContainer) =>
                      Avatar(
                    radius: 21,
                    url: user.profilePicture,
                    onTap: openContainer,
                  ),
                ),
                onPressed: () {},
              ),
              // Animation End
              const SizedBox(
                width: 12,
              ),
              // Name and Online status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      user.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    // TODO: have to implement online status
                    const Text(
                      "Online",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Call and video button
              IconButton(
                  splashRadius: 18.0,
                  onPressed: () {},
                  icon: const Icon(Icons.video_call_rounded)),
              IconButton(
                  splashRadius: 18.0,
                  onPressed: () {},
                  icon: const Icon(Icons.call)),
              // more button
              ChatScreenPopUpMenu(
                items: [
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 5,
                      right: 10,
                    ),
                    child: Text("View public profile"),
                    value: "profile",
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    child: Text("Search"),
                    value: "search",
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    child: Text("Media"),
                    value: "media",
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    child: Text("Wallpaper"),
                    value: "wallpaper",
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    child: Text("Mute Notifications"),
                    value: "mute",
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    child: Text("Add Shortcut"),
                    value: "shortcut",
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    child: Text("Block"),
                    value: "block",
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    child: Text("Clear chat"),
                    value: "clear",
                  ),
                ],
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
