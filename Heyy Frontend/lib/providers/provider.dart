import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/menu_items.dart';
import '../models/models.dart';

// Registration screen specific provider
// Country _selectedCountry = Country(
//     phoneCode: "91",
//     countryCode: "IN",
//     e164Sc: 0,
//     geographic: true,
//     level: 1,
//     name: "India",
//     example: "India",
//     displayName: "India",
//     displayNameNoCountryCode: "IN",
//     e164Key: "");

// final countryCodeProvider = StateProvider<Country>(
//   ((ref) => _selectedCountry),
// );

// final phoneControllerProvider = StateProvider<TextEditingController>(
//   (ref) => TextEditingController(),
// );
// end

// Fake data provider
final fakeUserProvider = StateProvider<List<User>>(
  (ref) => fakeuser,
);

final fakeStoryProvider = StateProvider<List<StoryData>>(
  (ref) => stories,
);
// End

// Message Page data providers
PopupMenuItem<dynamic> _menuItem(String text, dynamic value) {
  return PopupMenuItem(
    padding: EdgeInsets.only(
      left: 30,
      bottom: 3,
      top: 5,
      right: 10,
    ),
    child: Text(text),
    value: value,
  );
}

List<PopupMenuEntry> items = [
  _menuItem("Mute notifications", "mute"),
  _menuItem("Star", "star"),
  _menuItem("Archive", "archive"),
  _menuItem("Delete", "delete"),
];

final messageTilePopUpOptionsProvider = Provider<List<PopupMenuEntry>>(
  (ref) => items,
);
// End

// Home Screen Specifc drawer items
// Message page menu items
List<MenuItems> messagePageDrawerMenuItems = [
  MenuItems(text: "All", icon: Icons.all_inbox, onPressed: () {}),
  MenuItems(text: "Starred", icon: Icons.star, onPressed: () {}),
  MenuItems(text: "Community", icon: Icons.people_rounded, onPressed: () {}),
  MenuItems(text: "Archive", icon: Icons.archive, onPressed: () {}),
  MenuItems(text: "Request", icon: Icons.download_done, onPressed: () {}),
];

// Feed page menu items
List<MenuItems> feedPageDrawerMenuItems = [
  MenuItems(text: "All", icon: Icons.all_inbox, onPressed: () {}),
  MenuItems(text: "Trending", icon: Icons.trending_up, onPressed: () {}),
  MenuItems(text: "Subscribed", icon: Icons.play_arrow, onPressed: () {}),
];

// Call page menu items
List<MenuItems> callPageDrawerMenuItems = [
  MenuItems(text: "All", icon: Icons.all_inbox, onPressed: () {}),
];

final homeScreenDrawerMenuItemsProvider = StateProvider<List<MenuItems>>(
  (ref) => messagePageDrawerMenuItems,
);
// End

// Settings page menu
List<MenuItems> _settingsScreenMenuItems = [
  MenuItems(text: "Account", icon: Icons.key, onPressed: () {}),
  MenuItems(text: "Privacy", icon: Icons.privacy_tip, onPressed: () {}),
  MenuItems(text: "Chats", icon: Icons.chat, onPressed: () {}),
  MenuItems(text: "Notifications", icon: Icons.notifications, onPressed: () {}),
  MenuItems(text: "Storage and data", icon: Icons.storage, onPressed: () {}),
  MenuItems(text: "Language", icon: Icons.language, onPressed: () {}),
  MenuItems(text: "Help", icon: Icons.question_mark, onPressed: () {}),
  MenuItems(text: "Invite a friend", icon: Icons.person_2, onPressed: () {}),
];

final settingsScreenMenuItemsProvider = Provider<List<MenuItems>>(
  (ref) => _settingsScreenMenuItems,
);
// End