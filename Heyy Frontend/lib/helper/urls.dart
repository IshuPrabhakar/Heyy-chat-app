abstract class Urls {
  static const String _baseUrl =
      "";

  static const String register = _baseUrl + "/app/api/register";
  static const String verify = _baseUrl + "/app/api/verify";
  static const String getRefreshToken = _baseUrl + "/app/api/get-token";

  static const String userInfo = _baseUrl + "/app/api/user-info";
  static const String userPhoto = _baseUrl + "/app/api/user-info/photo";

  static const String deviceInfo = _baseUrl + "/app/api/device-info";
}
