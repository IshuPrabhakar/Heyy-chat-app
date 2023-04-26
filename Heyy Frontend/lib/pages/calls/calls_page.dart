import 'package:flutter/material.dart';

import '../../common/avatar.dart';
import '../../theme.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // favourate contacts
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: SizedBox(
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 8, bottom: 10),
                      child: Text(
                        "Frequents",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: AppColors.textFaded,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 65,
                              height: 65,
                              child: _FavourateContactsCard(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // All contacts list
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) {},
        //   ),
        // ),
      ],
    );
  }
}

class _FavourateContactsCard extends StatelessWidget {
  const _FavourateContactsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Avatar.medium(
              url:
                  'https://fsb.zobj.net/crop.php?r=FAcicNvLZvREd2P2K5zZ9L0JIRulV8TzAV5foNxUVRxrsoW0wh3DgQIozJv0HSgWCILHwsKEwVb865BLg-L9RKoE96jm-7VwmGTAwdmjbEgLZ1TTzZmX-5RfzkY2LYrpQj8ArPyITHBy0-abcIOq3hQ8yhEJBVpdeUT_tDOShgQVAuuKvlBjqVJj9Y7-Gk6rcT3kOY0zyR2NwKVL'),
          onTap: () {
            // Navigator.of(context).push(
            //   StoryScreen.route(userStories),
            // );
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: Text(
              "Rohit",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
