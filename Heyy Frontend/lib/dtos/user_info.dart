class UserInfo {
  late String name;
  late String? mobile;
  late String? profession;
  late String? bio;

  UserInfo({
    required this.name,
    this.mobile,
    this.profession,
    this.bio,
  });

  UserInfo.fromMap(Map<String, dynamic> map) {
    this.name = map["name"];
    this.bio = map["bio"];
    this.mobile = map["mobile"];
    this.profession = map["profession"];
  }

  Map<String, dynamic> toMap() => {
        "name": this.name,
        "bio": this.bio,
        "mobile": this.mobile,
        "profession": this.profession,
      };
}
