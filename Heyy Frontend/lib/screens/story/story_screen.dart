import 'package:flutter/material.dart';
import 'package:social/models/models.dart';
import 'package:social/theme.dart';
import 'package:social/common/avatar.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryScreen extends StatefulWidget {
  final StoryData storyData;

  const StoryScreen({Key? key, required this.storyData}) : super(key: key);

  // this is for navigation
  static Route route(StoryData data) => MaterialPageRoute(
        builder: (context) => StoryScreen(
          storyData: data,
        ),
      );

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  // it is better to initialsize variables using late keyword
  // as initstate doesn't work all the time
  late StoryData storydata = widget.storyData;
  late final initialPage = stories.indexOf(storydata);
  late final PageController _pageController =
      PageController(initialPage: initialPage);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: stories // total story list
          .map(
              (e) => StoryWidget(storyData: e, pageController: _pageController))
          .toList(),
    );
  }
}

// Story Widget
class StoryWidget extends StatefulWidget {
  final StoryData storyData;
  final PageController pageController;

  const StoryWidget(
      {Key? key, required this.storyData, required this.pageController})
      : super(key: key);

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  final List<StoryItem> storyitems = [];
  final StoryController _storyController = StoryController();
  late final ValueNotifier<String> date =
      ValueNotifier(widget.storyData.stories[0].date);

  void addStoryItems() {
    for (var story in widget.storyData.stories) {
      if (story.mediaType == MediaType.image) {
        storyitems.add(StoryItem.pageImage(
            url: story.url,
            controller: _storyController,
            caption: story.caption,
            duration: story.duration));
      } else if (story.mediaType == MediaType.video) {
        storyitems.add(StoryItem.pageVideo(story.url,
            controller: _storyController,
            caption: story.caption,
            duration: story.duration));
      }
      // TODO: have to implement only text type stories as well
    }
  }

  // Check if user is not null
  void isStoryExists() {}

  // IconButton Action Handeler
  void onBackButtonPressed() {
    Navigator.of(context).pop();
  }

  void handleCompleted() {
    widget.pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    addStoryItems();

    return Scaffold(
      body: Stack(
        children: [
          Material(
            type: MaterialType.transparency,
            child: StoryView(
                controller: _storyController,
                storyItems: storyitems,
                onComplete: (() {
                  handleCompleted();
                  // This block of is for to go back if it is the last story which is being shown
                  final currentIndex = stories.indexOf(widget.storyData);
                  final isLastPage = stories.length - 1 == currentIndex;

                  if (isLastPage) {
                    Navigator.of(context).pop();
                  }
                }),

                onVerticalSwipeComplete: (direction) {
                  if (direction == Direction.down) {
                    Navigator.pop(context);
                  }
                },
                onStoryShow: (storyItem) {
                  final index = storyitems.indexOf(storyItem);
                  if (index > 0) {
                    date.value = widget.storyData.stories[index].date;
                  }
                }),
          ),
          SafeArea(
            top: true,
            right: true,
            left: true,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  IconButton(
                      padding: const EdgeInsets.all(0),
                      splashRadius: 20,
                      onPressed: onBackButtonPressed,
                      icon: const Icon(Icons.arrow_back)),
                  // Profile button
                  IconButton(
                    alignment: Alignment.centerLeft,
                    splashRadius: 25,
                    padding: const EdgeInsets.all(0),
                    icon: Avatar(
                        radius: 22, url: widget.storyData.profilePicture),
                    onPressed: () {
                      onBackButtonPressed;
                    },
                  ),
                  // Name and story post date
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 5, 0, 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name of the user
                        Text(
                          widget.storyData.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textLight,
                            fontSize: 15,
                          ),
                        ),
                        // Date
                        // TODO: to change date on navigating to previous story
                        ValueListenableBuilder(
                            valueListenable: date,
                            builder: ((BuildContext context, String value, _) {
                              return Text(
                                value,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: AppColors.textLight,
                                  fontSize: 13,
                                ),
                              );
                            })
                            // Text(
                            //   date,
                            //   style: const TextStyle(
                            //     fontWeight: FontWeight.w100,
                            //     fontSize: 13,
                            //   ),
                            // )
                            )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
