import 'package:dio/dio.dart';
import 'http.dart';

class AuthApi {
  static Future<Response> login(String username, String password) async {
    return await HttpUtil.post('/login', data: {
      'username': username,
      'password': password,
    });
  }

  static Future<Response> getUserInfo() async {
    return await HttpUtil.get('/getInfo');
  }

  static Future<Response> changePassword(String oldPassword, String newPassword) async {
    return await HttpUtil.put('/user/password', data: {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    });
  }

  static Future<Response> logout() async {
    return await HttpUtil.post('/api/logout');
  }
}
