import 'package:get_storage/get_storage.dart';

class PrefData {
  static final PrefData _singleton = PrefData._internal();

  factory PrefData() {
    return _singleton;
  }

  // ignore: prefer_typing_uninitialized_variables
  var userDetailDataListener;

  PrefData._internal();

  void setIsLogin(bool? isLogin) {
    GetStorage().write("isLogin", isLogin);
  }

  bool isLogin() {
    return GetStorage().read("isLogin") ?? false;
  }

  void setAuthToken(String? accessToken) {
    GetStorage().write("accessToken", accessToken);
  }

  String getAuthToken() {
    return GetStorage().read("accessToken") ?? "";
  }

  void setOTPAuthToken(String? accessToken) {
    GetStorage().write("otp_accessToken", accessToken);
  }

  String getOTPAuthToken() {
    return GetStorage().read("otp_accessToken");
  }

  void setRefreshToken(String? accessToken) {
    GetStorage().write("refreshToken", accessToken);
  }

  String getRefreshToken() {
    return GetStorage().read("refreshToken");
  }

  clearData() {
    GetStorage().erase();
  }

  void setProfileUrl(String? profileUrl) {
    GetStorage().write("profileUrl", profileUrl);
  }

  String getProfileUrl() {
    if (GetStorage().read("profileUrl") != null) {
      return GetStorage().read("profileUrl");
    }
    return "";
  }

  bool isTokenSent() {
    var token = GetStorage().read("token") ?? false;
    return token;
  }

  void setToken() {
    GetStorage().write("token", true);
  }



}
