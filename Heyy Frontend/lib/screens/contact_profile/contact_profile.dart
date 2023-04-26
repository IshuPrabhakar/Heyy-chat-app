import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/bordered_button.dart';
import '../../common/utils.dart';
import '../../theme.dart';
import '../editprofile/editprofile.dart';
import '../profile/widgets/options_bottom_sheet.dart';
import '../qr_scanner/qr_view.dart';

class ContactProfile extends StatefulWidget {
  const ContactProfile({
    Key? key,
  }) : super(key: key);

  // this is for navigation
  static Route route() => MaterialPageRoute(
        builder: (context) => ContactProfile(),
      );

  @override
  State<ContactProfile> createState() => _ContactProfileState();
}

class _ContactProfileState extends State<ContactProfile> {
  NetworkImage? image = NetworkImage(
      'https://fsb.zobj.net/crop.php?r=FAcicNvLZvREd2P2K5zZ9L0JIRulV8TzAV5foNxUVRxrsoW0wh3DgQIozJv0HSgWCILHwsKEwVb865BLg-L9RKoE96jm-7VwmGTAwdmjbEgLZ1TTzZmX-5RfzkY2LYrpQj8ArPyITHBy0-abcIOq3hQ8yhEJBVpdeUT_tDOShgQVAuuKvlBjqVJj9Y7-Gk6rcT3kOY0zyR2NwKVL');

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: _ContactAppBar(brightness: brightness),
        body: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            // Profile pic
            Align(
              alignment: Alignment.bottomCenter,
              child: image == null
                  ? CircleAvatar(
                      backgroundColor: brightness == Brightness.light
                          ? Colors.grey.shade100
                          : AppColors.cardDark,
                      radius: 60,
                      child: Icon(
                        Icons.account_circle,
                        size: 60,
                      ), // Replace with lottie animation
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://fsb.zobj.net/crop.php?r=FAcicNvLZvREd2P2K5zZ9L0JIRulV8TzAV5foNxUVRxrsoW0wh3DgQIozJv0HSgWCILHwsKEwVb865BLg-L9RKoE96jm-7VwmGTAwdmjbEgLZ1TTzZmX-5RfzkY2LYrpQj8ArPyITHBy0-abcIOq3hQ8yhEJBVpdeUT_tDOShgQVAuuKvlBjqVJj9Y7-Gk6rcT3kOY0zyR2NwKVL'),
                      radius: 60,
                    ),
            ),

            SizedBox(
              height: 18,
            ),

            // Name and bio working status
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        // TODO add provider here
                        "Rohit sharma",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Your bio should appear here..",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "SDE - Microsoft", // interpolated string
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // follow following
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 60,
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       Text(
                      //         "1.2k followers", // interpolated string
                      //         style: TextStyle(
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //       Text(
                      //         "12 following", // interpolated string
                      //         style: TextStyle(
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 35,
            ),

            // Quick Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _quickActionButton("Call", Icons.call, () {}),
                  _quickActionButton("Message", Icons.message, () {}),
                  _quickActionButton("Video Call", Icons.video_call, () {}),
                ],
              ),
            ),

            SizedBox(
              height: 50,
            ),

            // Shared Media
            Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                      ),
                      child: Text(
                        "Shared Media",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textFaded,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                      ),
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textFaded,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),

            // Options
            SizedBox(
              height: 200,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _menuItem(
                      "Mute notifications", Icons.notifications_off, () {}),
                  _menuItem("Theme and Wallpaper", Icons.photo, () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _menuItem(String text, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        leading: Icon(
          icon,
          size: 27,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: AppColors.textFaded,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Column _quickActionButton(String text, IconData icon, VoidCallback onTap) {
    return Column(
      children: [
        CustomBorderedButton(
          radius: 27,
          onPressed: onTap,
          icon: icon,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textFaded,
            letterSpacing: .6,
          ),
        ),
      ],
    );
  }
}

class _ContactAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ContactAppBar({
    super.key,
    required this.brightness,
  });

  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            (Theme.of(context).brightness != Brightness.light)
                ? Brightness.light
                : Brightness.dark,
        statusBarBrightness: (Theme.of(context).brightness == Brightness.light)
            ? Brightness.light
            : Brightness.dark,
      ),
      iconTheme: Theme.of(context).iconTheme,
      elevation: 0,
      backgroundColor: Theme.of(context).cardColor,
      leading: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          top: 8,
        ),
        child: CustomBorderedButton(
          icon: Icons.arrow_back,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: Text(
        "Rohit Sharma",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: brightness == Brightness.light
              ? AppColors.textDark
              : AppColors.textLight,
        ),
      ),
      actions: [
        CustomBorderedButton(
          icon: Icons.qr_code,
          onPressed: () {
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
        SizedBox(
          width: 10,
        ),

        // Edit button
        CustomBorderedButton(
          radius: 20,
          onPressed: () {
            Navigator.of(context).push(
              EditUserProfile.route(),
            );
          },
          icon: Icons.edit,
        ),

        SizedBox(
          width: 10,
        ),

        // more button
        CustomBorderedButton(
          onPressed: () {
            showCustomBottomSheet(
              context,
              MoreActionsBottomSheet(),
              .3,
              .3,
            );
          },
          icon: Icons.more_vert,
        ),
        SizedBox(
          width: 12,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
