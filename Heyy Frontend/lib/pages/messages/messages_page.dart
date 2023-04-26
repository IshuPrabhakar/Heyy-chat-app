import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social/helper/master_user.dart';
import 'package:social/screens/story/story_screen.dart';
import 'package:social/theme.dart';

import '../../models/models.dart';
import '../../common/common.dart';
import 'widgets/message_tile.dart';

class MessagesPage extends StatelessWidget {
  MessagesPage({Key? key}) : super(key: key);

  // Fake message's page  data
  final List<User> users = fakeuser;
  final List<StoryData> userStories = stories;

  // TODO: have to implement methods to show name, dates and all in message tile of sliverlist
  // so that, it can change state when user is typing..

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _Stories(
            userStories: userStories,
          ),
        ),
        // If other Users become null then display no user
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: users.length,
            (BuildContext context, int index) {
              if (users.isEmpty) {
                return const Center(
                  child: Text("No chats yet."),
                );
              } else {
                return MessageTitle(user: users[index]);
              }
            },
          ),
        ),
      ],
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({Key? key, required this.userStories}) : super(key: key);

  final List<StoryData> userStories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: SizedBox(
          height: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 8, bottom: 10),
                child: Text(
                  "Stories",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: AppColors.textFaded,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: userStories.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(60.0),
                                    ),
                                    onTap: () {
                                      print("Have to implement later");
                                    },
                                    child: Avatar(
                                      radius: 31,
                                      url: MasterUser()
                                          .masterUser
                                          .profilePicture,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2.0,
                                  ),
                                  const Text(
                                    "You",
                                    style: TextStyle(
                                      fontSize: 12,
                                      letterSpacing: 0.3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 25.0,
                                right: 3.0,
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(60),
                                      ),
                                      color: Colors.lightBlue),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: _StoryCard(
                            userStories: userStories[index - 1],
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key? key,
    required this.userStories,
  }) : super(key: key);

  final StoryData userStories;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: CustomPaint(
            painter: StoryPainter(),
            child: Avatar.medium(url: userStories.profilePicture),
          ),
          onTap: () {
            Navigator.of(context).push(
              StoryScreen.route(userStories),
            );
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: Text(
              userStories.username,
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

// Custom painter to draw circle around the unseen status
class StoryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 0.7
      ..color =
          AppColors.secondary // TODO: CHange color according to view status
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.7;

    drawArc(canvas, size, paint);
  }

  degreeToAngle(double degree) {
    return degree * pi / 100;
  }

  void drawArc(Canvas canvas, Size size, Paint paint) {
    canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        degreeToAngle(0), degreeToAngle(360), false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
