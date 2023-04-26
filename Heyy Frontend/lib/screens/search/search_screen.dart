import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/bordered_button.dart';
import '../../theme.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  // this is for navigation
  static Route route() => MaterialPageRoute(
        builder: (context) => SearchScreen(),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final searchController = TextEditingController();

// TODO add qr scanner
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: (brightness != Brightness.light)
              ? Brightness.light
              : Brightness.dark,
          statusBarBrightness: (brightness == Brightness.light)
              ? Brightness.light
              : Brightness.dark,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            bottom: 10,
            top: 10,
            right: 0,
          ),
          child: CustomBorderedButton(
            icon: Icons.arrow_back,
            radius: 22,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: SizedBox(
          height: 45,
          width: MediaQuery.of(context).size.width / 1.3,
          child: _textField(
              brightness: brightness,
              hintText: "Search",
              type: TextInputType.text,
              maxLines: 1,
              controller: searchController,
              icon: null),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              left: 0,
              bottom: 8,
              top: 8,
              right: 8,
            ),
            child: CustomBorderedButton(
              icon: Icons.cancel_outlined,
              radius: 22,
              onPressed: () {
                if (searchController.text.length == 0) {
                  Navigator.of(context).pop();
                } else {
                  searchController.clear();
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    leading: Icon(Icons.person),
                    title: Text("Rohit sharma"),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _textField(
    {required String hintText,
    IconData? icon,
    required TextInputType type,
    required int maxLines,
    required TextEditingController controller,
    required Brightness brightness}) {
  return TextFormField(
    textAlignVertical: TextAlignVertical.center,
    controller: controller,
    maxLines: maxLines,
    cursorColor: AppColors.secondary,
    keyboardType: type,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      hintText: hintText,
      hintStyle: TextStyle(
        color: brightness == Brightness.light
            ? AppColors.textDark
            : AppColors.textLight,
      ),
      alignLabelWithHint: true,
      border: InputBorder.none,
      fillColor: brightness == Brightness.light
          ? Colors.grey.shade100
          : AppColors.cardDark,
      filled: true,
    ),
  );
}
