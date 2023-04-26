import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/bordered_button.dart';
import '../../../common/utils.dart';
import '../../../theme.dart';
import '../../editprofile/editprofile.dart';
import 'options_bottom_sheet.dart';

class UserProfileAppBar extends StatefulWidget implements PreferredSizeWidget {
  const UserProfileAppBar({super.key});

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
  NetworkImage? image = NetworkImage(
      'https://fsb.zobj.net/crop.php?r=FAcicNvLZvREd2P2K5zZ9L0JIRulV8TzAV5foNxUVRxrsoW0wh3DgQIozJv0HSgWCILHwsKEwVb865BLg-L9RKoE96jm-7VwmGTAwdmjbEgLZ1TTzZmX-5RfzkY2LYrpQj8ArPyITHBy0-abcIOq3hQ8yhEJBVpdeUT_tDOShgQVAuuKvlBjqVJj9Y7-Gk6rcT3kOY0zyR2NwKVL');

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
        "Rohit Sharma",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
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
      actions: [
        // Edit button
        CustomBorderedButton(
          radius: 20,
          onPressed: () {
            Navigator.of(context).push(
              EditUserProfile.route(),
            );
          },
          icon: Icons.edit,
        ),

        SizedBox(
          width: 10,
        ),

        // more button
        CustomBorderedButton(
          onPressed: () {
            showCustomBottomSheet(
              context,
              MoreActionsBottomSheet(),
              .3,
              .3,
            );
          },
          icon: Icons.more_vert,
        ),
        SizedBox(
          width: 12,
        ),
      ],
    );
  }
}
