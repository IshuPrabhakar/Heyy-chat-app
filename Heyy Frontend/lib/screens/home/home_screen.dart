import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social/pages/calls/calls_page.dart';
import 'package:social/pages/feed_page.dart';
import 'package:social/pages/messages/messages_page.dart';
import 'package:social/common/common.dart';

import '../../common/bordered_button.dart';
import 'dart:io';
import '../../main.dart';
import '../../models/menu_items.dart';
import '../../providers/provider.dart';
import '../../theme.dart';
import '../search/search_screen.dart';
import 'widgets/bottom_navigation_bar.dart';
import 'widgets/left_drawer.dart';
import 'widgets/right_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // this is for navigation
  static Route route() => MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  /// This is to change these data on stateless widgets
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  /// List to iterate over to switch pages
  final pages = [
    MessagesPage(),
    const FeedPage(),
    const CallsPage(),
  ];

  final pageTitles = const [
    'Messages',
    'Feed',
    'Calls',
  ];

  // Custom method to change page title and index
  // and update side drawers options accordingly
  void _onNavigationItemSelected(index) {
    switch (pageTitles[index]) {
      case 'Messages':
        updateDrawerMenu(messagePageDrawerMenuItems);
        break;
      case 'Feed':
        updateDrawerMenu(feedPageDrawerMenuItems);
        break;
      case 'Calls':
        updateDrawerMenu(callPageDrawerMenuItems);
        break;
      default:
    }
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  // update left drawers menu item
  void updateDrawerMenu(List<MenuItems> menuItems) {
    ref
        .read(homeScreenDrawerMenuItemsProvider.notifier)
        .update((state) => menuItems);
  }

  // LeftSide navigation drawer
  void showDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  // right side notification drawer
  void showNotificationDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  // local variable
  File? _image;

  @override
  void initState() {
    super.initState();

    if (admin != null) {
      _image = File(admin!.profileUrl ?? "");
      debugPrint(_image!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return WillPopScope(
      onWillPop: () async {
        // Exit App if user is logged in
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else
          exit(0);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                (Theme.of(context).brightness != Brightness.light)
                    ? Brightness.light
                    : Brightness.dark,
            statusBarBrightness:
                (Theme.of(context).brightness == Brightness.light)
                    ? Brightness.light
                    : Brightness.dark,
          ),
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: ValueListenableBuilder(
            valueListenable: title,
            builder: (BuildContext context, String value, _) {
              return Center(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
          // Profile Image
          leadingWidth: 70,
          leading: Builder(
            builder: (context) {
              return Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  splashRadius: 20,
                  icon: _image == null
                      ? CircleAvatar(
                          backgroundColor: brightness == Brightness.light
                              ? Colors.grey.shade100
                              : AppColors.cardDark,
                          radius: 17,
                          child: Icon(
                            Icons.account_circle,
                            size: 35,
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(_image!),
                          radius: 17,
                        ),
                  onPressed: () {
                    showDrawer(context);
                  },
                ),
              );
            },
          ),
          actions: [
            CustomBorderedButton(
              icon: Icons.search,
              radius: 18,
              onPressed: () {
                Navigator.of(context).push(SearchScreen.route());
              },
            ),
            SizedBox(
              width: 8,
            ),
            Builder(
              builder: (context) {
                return CustomBorderedButton(
                  icon: Icons.notifications,
                  radius: 18,
                  onPressed: () {
                    showNotificationDrawer(context);
                  },
                );
              },
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: ValueListenableBuilder(
          /// this to change pages in stateless widgets
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          onItemSelected: _onNavigationItemSelected,
        ),
        drawer: LeftSideMenuDrawer(),
        endDrawerEnableOpenDragGesture: true,
        endDrawer: NotificationsDrawer(),
      ),
    );
  }
}
