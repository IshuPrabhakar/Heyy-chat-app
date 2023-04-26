import 'package:flutter/material.dart';

import 'navigation_bar_item.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationBarItem(
                index: 0,
                lable: 'Messages',
                icon: Icons.message,
                isSelected: (selectedIndex == 0),
                onTap: handleItemSelected,
              ),
              // TODO: Feed will be implemented in thee future release.
              // NavigationBarItem(
              //   index: 1,
              //   lable: 'Feed',
              //   icon: Icons.home_outlined,
              //   isSelected: (selectedIndex == 1),
              //   onTap: handleItemSelected,
              // ),
              NavigationBarItem(
                index: 2,
                lable: 'Calls',
                icon: Icons.call,
                isSelected: (selectedIndex == 2),
                onTap: handleItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}