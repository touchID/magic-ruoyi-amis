import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setToken(String token) {
    return _prefs.setString('token', token);
  }

  static String? getToken() {
    return _prefs.getString('token');
  }

  static Future<bool> removeToken() {
    return _prefs.remove('token');
  }

  static Future<bool> setUserInfo(Map<String, dynamic> userInfo) {
    return _prefs.setString('userInfo', userInfo.toString());
  }

  static String? getUserInfo() {
    return _prefs.getString('userInfo');
  }

  static Future<bool> removeUserInfo() {
    return _prefs.remove('userInfo');
  }
}
