import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/bordered_button.dart';
import '../../../theme.dart';

class EditProfileScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const EditProfileScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
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
      title: Text(
        "Edit Profile",
        style: TextStyle(
          color: brightness == Brightness.light
              ? AppColors.textDark
              : AppColors.textLight,
        ),
      ),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
