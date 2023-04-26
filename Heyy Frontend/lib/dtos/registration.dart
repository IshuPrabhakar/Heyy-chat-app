class RegistrationResponse {
  late DateTime OtpSentTime;
  late String Hash;

  RegistrationResponse({
    required this.OtpSentTime,
    required this.Hash,
  });

  RegistrationResponse.fromMap(Map<String, dynamic> map) {
    this.Hash = map['hash'];
    this.OtpSentTime = DateTime.parse(map['otpSentTime']);
  }

  Map<String, dynamic> toMap() => {
        "hash": this.Hash,
        "otpSentTime": this.OtpSentTime.toIso8601String(),
      };
}
