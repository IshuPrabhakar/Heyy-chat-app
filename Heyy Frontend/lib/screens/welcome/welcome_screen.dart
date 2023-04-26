import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:social/main.dart';

import '../../common/round_rect_button.dart';
import '../chat/constants/constants.dart';
import '../registration/registration.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  // this is for navigation
  static Route route() => MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      );

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return WillPopScope(
      onWillPop: () async {
        // Exit App if user is logged in
        if (Platform.isAndroid){
          SystemNavigator.pop();
        }
        else
          exit(0);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.1,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: brightness == Brightness.light
                            ? Colors.transparent
                            : Colors.lightBlue.shade50,
                      ),
                      child: Lottie.asset(
                        'assets/get-in-touch-with-us-online-managers.json',
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      "Let's get started",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Never a better time than now to start.",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Custom Rounded Rectangle button
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: 50,
                      child: RoundRectanlgeButton(
                        onPressed: () {
                          // Navigation for the Registration page
                          Navigator.of(context)
                              .push(RegistrationScreen.route());
                        },
                        text: "Get's started",
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),

                    Text(
                      "Made with ${Reactions.Heart} in India ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
