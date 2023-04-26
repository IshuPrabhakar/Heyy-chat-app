import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id;

  @Index()
  String uuid;

  String? profileUrl;
  String name;
  String? mobile;
  String? profession;
  String? bio;
  String? email;

  String? jwtToken;
  String? refreshToken;
  int? exp;

  int? isLoggedIn;

  User({
    required this.name,
    this.id = 0,
    this.bio,
    this.profession,
    this.mobile,
    this.exp,
    this.jwtToken,
    this.refreshToken,
    this.profileUrl,
    required this.uuid,
    this.isLoggedIn,
    this.email,
  });
}
