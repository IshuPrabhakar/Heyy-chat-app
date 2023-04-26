class HeyyError {
  late String errorcode;
  late String desc;

  HeyyError({
    required this.errorcode,
    required this.desc,
  });

  HeyyError.fromMap(Map<String, dynamic> map) {
    this.errorcode = map["errorcode"];
    this.desc = map["desc"];
  }

  Map<String, dynamic> toMap() => {
        "errorcode": this.errorcode,
        "desc": this.desc,
      };
}
