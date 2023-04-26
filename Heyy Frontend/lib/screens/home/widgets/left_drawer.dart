import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social/main.dart';
import 'package:social/screens/settings/settings.dart';

import '../../../common/bordered_button.dart';
import '../../../common/utils.dart';
import '../../../providers/provider.dart';
import '../../../theme.dart';
import '../../contact_profile/contact_profile.dart';
import '../../qr_scanner/qr_scanner.dart';
import '../../welcome/welcome_screen.dart';

class LeftSideMenuDrawer extends StatefulWidget {
  const LeftSideMenuDrawer({super.key});

  @override
  State<LeftSideMenuDrawer> createState() => _LeftSideMenuDrawerState();
}

class _LeftSideMenuDrawerState extends State<LeftSideMenuDrawer> {
  // local variable
  File? _image;
  String? _Name;
  String? _Email;

  @override
  void initState() {
    super.initState();

    if (admin != null) {
      _image = File(admin!.profileUrl ?? "");
      _Name = admin!.name;
      _Email = admin!.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Drawer(
      child: Column(
        children: [
          // Drawer header
          Container(
            padding: EdgeInsets.only(top: 55, left: 22),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: NetworkImage(
            //       "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
            //     ),
            //     fit: BoxFit.fill,
            //   ),
            // ),
            // profile image
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // profile, name and username
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      iconSize: 80,
                      highlightColor: Colors.transparent,
                      icon: _image == null
                          ? CircleAvatar(
                              backgroundColor: brightness == Brightness.light
                                  ? Colors.grey.shade100
                                  : AppColors.cardDark,
                              radius: 50,
                              child: Icon(
                                Icons.account_circle,
                                size: 70,
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(_image!),
                              radius: 50,
                            ),
                      onPressed: () {
                        Navigator.of(context).push(
                          ContactProfile.route(),
                        );
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // name and username
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _Name ?? "",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: (brightness == Brightness.light)
                                  ? AppColors.textDark
                                  : AppColors.textLight,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          //username
                          Text(
                            _Email ?? "",
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: (brightness == Brightness.light)
                                  ? AppColors.textDark
                                  : AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20, bottom: 40),
                  child: CustomBorderedButton(
                    icon: Icons.qr_code_scanner,
                    onPressed: () {
                      Navigator.of(context).push(QrScanner.route());
                    },
                  ),
                )
              ],
            ),
          ),

          // divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              // TODO hide divider when backgroud image is set
              thickness: 1,
              color: brightness == Brightness.light
                  ? Colors.grey.shade300
                  : Colors.grey.shade700,
            ),
          ),

          // ListItems
          Consumer(builder: (context, ref, child) {
            final menuItems = ref.watch(homeScreenDrawerMenuItemsProvider);
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: ListView.builder(
                  itemCount: menuItems.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        leading: CustomBorderedButton(
                          icon: menuItems[index].icon,
                          radius: 24,
                        ),
                        title: Text(
                          menuItems[index].text,
                          style: TextStyle(fontSize: 16),
                        ),
                        onTap: menuItems[index].onPressed,
                      ),
                    );
                  },
                ),
              ),
            );
          }),

          // Bottom action buttons
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomBorderedButton(
                  onPressed: () {
                    showAlertDialog(
                      context,
                      "Are you sure want to log out?",
                      "Logout",
                      onLogoutButtonPressed,
                    );
                  },
                  icon: Icons.logout,
                ),
                CustomBorderedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      SettingsScreen.route(),
                    );
                  },
                  icon: Icons.settings,
                ),
                CustomBorderedButton(
                  onPressed: () {},
                  icon: Icons
                      .dark_mode, // TODO make this icon dynamic with the theme
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onLogoutButtonPressed() {
    // Navigate to the welcome screen
    Navigator.of(context).push(WelcomeScreen.route());

    // logging out user
    var user = objectbox.user.get(1);
    if (user != null) {
      user.isLoggedIn = 0;
      objectbox.user.put(user);
    }
  }
}
