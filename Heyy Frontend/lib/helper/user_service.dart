import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social/dtos/error.dart';

import '../dtos/user_info.dart';
import 'urls.dart';

class UserApiService {
  // upload userinfo
  Future<int?> UpdateUserInfo({
    required UserInfo userinfo,
    required String Uuid,
    required String JwtToken,
  }) async {
    var headers = {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Authorization": "bearer ${JwtToken}",
      "Cookie": "userid=${Uuid}"
    };
    var response = await http.put(
      Uri.parse(Urls.userInfo),
      body: jsonEncode(userinfo.toMap()),
      headers: headers,
    );

    return response.statusCode;
  }

  Future<Object?> GetUserInfo({required UserInfo userinfo}) async {
    var response = await http.get(
      Uri.parse(Urls.userInfo),
      headers: {
        "Content-Type": "application/json",
      },
    );

    var result = response.statusCode;
    if (result == 200) {
      var res = UserInfo.fromMap(jsonDecode(response.body));
      return res;
    } else if (result == 400) {
      var res = HeyyError.fromMap(jsonDecode(response.body));
      return res;
    }
    return null;
  }
}
