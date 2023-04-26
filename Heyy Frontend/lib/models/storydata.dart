import 'package:social/models/models.dart';

class StoryData {
  final String username;
  final String profilePicture;
  final List<Story> stories;

  StoryData(
      {required this.profilePicture,
      required this.username,
      required this.stories});
}
