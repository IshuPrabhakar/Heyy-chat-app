import 'package:flutter/material.dart';

import '../../../common/bordered_button.dart';

class NotificationsDrawer extends StatefulWidget {
  const NotificationsDrawer({super.key});

  @override
  State<NotificationsDrawer> createState() => _NotificationsDrawerState();
}

class _NotificationsDrawerState extends State<NotificationsDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // TODO add provider here
                    "Notifications",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomBorderedButton(
                    icon: Icons.toggle_off,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // Notifcations list
          // Notifications
          // Expanded(
          //   child: ListView(
          //     children: [],
          //   ),
          // ),

          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "No notifcations yet",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
