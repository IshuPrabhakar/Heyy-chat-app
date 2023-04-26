import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/bordered_button.dart';
import '../../common/round_rect_button.dart';
import '../../providers/provider.dart';
import '../../theme.dart';
import '../chat/constants/constants.dart';
import '../editprofile/editprofile.dart';
import 'widget/appbar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  // this is for navigation
  static Route route() => MaterialPageRoute(
        builder: (context) => SettingsScreen(),
      );

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? image;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      appBar: SettingsScreenAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            right: 10,
            left: 10,
            bottom: 10,
          ),
          child: Column(
            children: [
              // profile pic
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    image == null
                        ? CircleAvatar(
                            backgroundColor: brightness == Brightness.light
                                ? Colors.grey.shade100
                                : AppColors.cardDark,
                            radius: 60,
                            child: Icon(
                              Icons.account_circle,
                              size: 120,
                              color: Colors.blue.shade600,
                            ), // Replace with lottie animation
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(image!),
                            radius: 60,
                          ),
                    const SizedBox(
                      height: 18,
                    ),

                    // Name
                    Text(
                      "Rohit Sharma",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    SizedBox(
                      width: 150,
                      height: 45,
                      child: RoundRectanlgeButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            EditUserProfile.route(),
                          );
                        },
                        text: "Edit Profile",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              Consumer(
                builder: (context, ref, child) {
                  final menuItems = ref.read(settingsScreenMenuItemsProvider);
                  return SizedBox(
                    height: 600,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: menuItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              onTap: menuItems[index].onPressed,
                              leading: CustomBorderedButton(
                                icon: menuItems[index].icon,
                                radius: 22,
                              ),
                              title: Text(
                                menuItems[index].text,
                                style: TextStyle(fontSize: 17),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Made with ${Reactions.Heart} in India ",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
