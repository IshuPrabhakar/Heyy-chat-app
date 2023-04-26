import 'package:social/models/models.dart';

class User {
  final String name;
  final String? profilePicture;
  final String phone;
  final String email;

  final MessagePreview? preview;
  final bool isPinned;
  // final Conversation conversation
  // between you and other user

  User(
      {required this.name,
      this.profilePicture,
      required this.phone,
      required this.email,
      this.preview,
      this.isPinned = false});

  // OTP based login so, don't need to store password
}
