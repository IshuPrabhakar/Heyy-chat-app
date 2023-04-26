import 'package:flutter/material.dart';

import '../../common/bordered_button.dart';
import '../../common/round_rect_button.dart';
import '../../theme.dart';
import 'widgets/appbar.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);

  // this is for navigation
  static Route route() => MaterialPageRoute(
        builder: (context) => UserProfile(),
      );

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  NetworkImage? image = NetworkImage(
      'https://fsb.zobj.net/crop.php?r=FAcicNvLZvREd2P2K5zZ9L0JIRulV8TzAV5foNxUVRxrsoW0wh3DgQIozJv0HSgWCILHwsKEwVb865BLg-L9RKoE96jm-7VwmGTAwdmjbEgLZ1TTzZmX-5RfzkY2LYrpQj8ArPyITHBy0-abcIOq3hQ8yhEJBVpdeUT_tDOShgQVAuuKvlBjqVJj9Y7-Gk6rcT3kOY0zyR2NwKVL');

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: UserProfileAppBar(),
        body: ListView(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 270,
                  width: double.infinity,
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        height: 240,
                        width: double.infinity,
                        // Cover photo wiill be here
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Edit cover button
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CustomBorderedButton(
                              icon: Icons.camera_alt_rounded,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Profile pic
                Align(
                  alignment: Alignment.bottomCenter,
                  child: image == null
                      ? CircleAvatar(
                          backgroundColor: brightness == Brightness.light
                              ? Colors.grey.shade100
                              : AppColors.cardDark,
                          radius: 65,
                          child: Icon(
                            Icons.account_circle,
                            size: 65,
                          ), // Replace with lottie animation
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://fsb.zobj.net/crop.php?r=FAcicNvLZvREd2P2K5zZ9L0JIRulV8TzAV5foNxUVRxrsoW0wh3DgQIozJv0HSgWCILHwsKEwVb865BLg-L9RKoE96jm-7VwmGTAwdmjbEgLZ1TTzZmX-5RfzkY2LYrpQj8ArPyITHBy0-abcIOq3hQ8yhEJBVpdeUT_tDOShgQVAuuKvlBjqVJj9Y7-Gk6rcT3kOY0zyR2NwKVL'),
                          radius: 65,
                        ),
                ),
              ],
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
                        height: 20,
                      ),
                      Text(
                        "SDE - Microsoft", // interpolated string
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // follow following
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "1.2k followers", // interpolated string
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "12 following", // interpolated string
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 30,
            ),

            // Quick Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _quickActionButton(
                    brightness,
                    "Follow",
                    () {},
                  ),
                  _quickActionButton(
                    brightness,
                    "Message",
                    () {},
                  ),
                  _quickActionButton(
                    brightness,
                    "Share profile",
                    () {},
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 18,
            ),

            // Tabbar
            TabBar(
              indicatorColor: AppColors.secondary,
              labelColor: brightness == Brightness.light
                  ? AppColors.textDark
                  : AppColors.textLight,
              tabs: [
                Tab(
                  text: "Activity",
                ),
                Tab(
                  text: "Channel",
                ),
                Tab(
                  text: "Interest",
                ),
                Tab(
                  text: "About",
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 130,
              child: TabBarView(
                children: [
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.accent,
                    child: Center(
                      child: Text("Activity"),
                    ),
                  ),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.secondary,
                    child: Center(
                      child: Text("Channel"),
                    ),
                  ),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.amberAccent,
                    child: Center(
                      child: Text("Interest"),
                    ),
                  ),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.amber,
                    child: Center(
                      child: Text("About"),
                    ),
                  ),
                ],
              ),
            ),

            // SizedBox(
            //   height: 18,
            // ),

            // Container(
            //   height: 300,
            //   width: MediaQuery.of(context).size.width,
            //   color: AppColors.secondary,
            // ),

            // SizedBox(
            //   height: 18,
            // ),

            // Container(
            //   height: 300,
            //   width: MediaQuery.of(context).size.width,
            //   color: AppColors.secondary,
            // ),
          ],
        ),
      ),
    );
  }

  RoundRectanlgeButton _quickActionButton(
    Brightness brightness,
    String text,
    VoidCallback onPressed,
  ) {
    return RoundRectanlgeButton(
      onPressed: onPressed,
      text: text,
      fontSize: 15,
      elevation: 0,
      radius: 10,
      backgroundColor: brightness == Brightness.light
          ? AppColors.customIconButtonBackgroundLight
          : AppColors.customIconButtonBackgroundDark,
      color: brightness == Brightness.light
          ? AppColors.textDark
          : AppColors.textLight,
    );
  }
}
