import 'package:get/get.dart';
import '../api/auth_api.dart';
import '../models/user.dart';
import '../utils/storage.dart';

class UserController extends GetxController {
  final Rx<User?> _user = Rx<User?>(null);
  final RxString _token = RxString('');

  User? get user => _user.value;
  String get token => _token.value;
  bool get isLoggedIn => _token.value.isNotEmpty;

  Future<void> login(String username, String password) async {
    try {
      var response = await AuthApi.login(username, password);
      if (response.statusCode == 200) {
        _token.value = response.data['token'];
        await StorageUtil.setToken(_token.value);
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
        _user.value = User.fromJson(response.data);
        await StorageUtil.setUserInfo(_user.value!.toJson());
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
      _user.value = null;
      _token.value = '';
      await StorageUtil.removeToken();
      await StorageUtil.removeUserInfo();
    }
  }

  Future<void> init() async {
    _token.value = StorageUtil.getToken() ?? '';
    if (_token.value.isNotEmpty) {
      try {
        await getUserInfo();
      } catch (_) {
        _token.value = '';
        _user.value = null;
      }
    }
  }
}
