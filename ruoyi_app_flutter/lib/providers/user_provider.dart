import 'package:flutter/material.dart';
import '../api/auth_api.dart';
import '../models/user.dart';
import '../utils/storage.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  Future<void> login(String username, String password) async {
    try {
      var response = await AuthApi.login(username, password);
      if (response.statusCode == 200) {
        _token = response.data['token'];
        await StorageUtil.setToken(_token!);
        await getUserInfo();
      }
    } catch (e) {
      throw Exception('登录失败：用户名或密码错误');
    }
  }

  Future<void> getUserInfo() async {
    try {
      var response = await AuthApi.getUserInfo();
      if (response.statusCode == 200) {
        _user = User.fromJson(response.data);
        await StorageUtil.setUserInfo(_user!.toJson());
        notifyListeners();
      }
    } catch (e) {
      throw Exception('获取用户信息失败');
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      var response = await AuthApi.changePassword(oldPassword, newPassword);
      if (response.statusCode != 200) {
        throw Exception('修改密码失败');
      }
    } catch (e) {
      throw Exception('修改密码失败');
    }
  }

  Future<void> logout() async {
    try {
      await AuthApi.logout();
    } catch (_) {
    } finally {
      _user = null;
      _token = null;
      await StorageUtil.removeToken();
      await StorageUtil.removeUserInfo();
      notifyListeners();
    }
  }

  Future<void> init() async {
    _token = StorageUtil.getToken();
    if (_token != null) {
      try {
        await getUserInfo();
      } catch (e) {
        _token = null;
        _user = null;
      }
    }
  }
}
