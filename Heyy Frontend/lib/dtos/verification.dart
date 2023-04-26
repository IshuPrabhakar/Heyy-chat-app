import 'dart:convert';

class VerificationRequest {
  late String hash;
  late String email;
  late String otp;
  late DateTime otpSentTime;

  VerificationRequest({
    required this.email,
    required this.hash,
    required this.otp,
    required this.otpSentTime,
  });

  VerificationRequest.fromMap(Map<String, dynamic> map) {
    this.email = map['email'];
    this.hash = map['hash'];
    this.otp = map['otp'];
    this.otpSentTime = DateTime.parse(map['otpSentTime']);
  }

  Map<String, dynamic> toMap() => {
        'email': this.email,
        'hash': this.hash,
        'otp': this.otp,
        'otpSentTime': this.otpSentTime.toIso8601String(),
      };
}

class VerificationResponse {
  late String jwtToken;
  late int exp;
  late RefreshToken? refreshToken;

  VerificationResponse({
    required this.exp,
    required this.refreshToken,
    required this.jwtToken,
  });

  VerificationResponse.fromMap(Map<String, dynamic> map) {
    this.exp = map['exp'];
    this.refreshToken = RefreshToken.fromMap(map['refreshToken']);
    this.jwtToken = map['token'];
  }

  Map<String, dynamic> toMap() => {
        'exp': this.exp,
        'refreshToken': this.refreshToken,
        'token': this.jwtToken,
      };
}

class RefreshToken {
  late String token;
  late DateTime createdAt;
  late String uuid;

  RefreshToken({
    required this.createdAt,
    required this.token,
    required this.uuid,
  });

  RefreshToken.fromMap(Map<String, dynamic> map) {
    this.token = map['token'];
    this.createdAt = DateTime.parse(map['createdAt']);
    this.uuid = map['uuid'];
  }

  Map<String, dynamic> toMap() => {
        'token': this.token,
        'createdAt': this.createdAt.toIso8601String(),
        'uuid': this.uuid,
      };
}
