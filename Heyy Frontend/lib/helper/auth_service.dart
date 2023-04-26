import 'dart:convert';

import 'package:http/http.dart' as http;

import '../dtos/error.dart';
import '../dtos/registration.dart';
import '../dtos/verification.dart';
import 'helper.dart';

class AuthenticationApiService {
  // Send Otp
  Future<Object?> sendOtp({required String email}) async {
    var data = {
      "email": email,
    };
    var headers = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };
    var response = await http.post(
      Uri.parse(Urls.register),
      body: jsonEncode(data),
      headers: headers,
    );

    var result = response.statusCode;
    if (result == 200) {
      var res = RegistrationResponse.fromMap(jsonDecode(response.body));
      return res;
    } else if (result == 400) {
      var res = HeyyError.fromMap(jsonDecode(response.body));
      return res;
    }
    return null;
  }

  // Send Otp
  Future<Object?> verifyOtp({
    required VerificationRequest request,
  }) async {
    var headers = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };
    var response = await http.post(
      Uri.parse(Urls.verify),
      body: jsonEncode(request.toMap()),
      headers: headers,
    );

    var result = response.statusCode;
    if (result == 200) {
      var res = VerificationResponse.fromMap(jsonDecode(response.body));
      return res;
    } else if (result == 400) {
      var res = HeyyError.fromMap(jsonDecode(response.body));
      return res;
    }
    return null;
  }
}
