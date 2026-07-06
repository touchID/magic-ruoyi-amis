import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/user_controller.dart';
import '../../routes/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map<String, dynamic>> _menuItems = [
    {'title': '个人设置', 'icon': Icons.settings, 'arrow': true},
    {'title': '修改密码', 'icon': Icons.lock, 'arrow': true},
    {'title': '系统消息', 'icon': Icons.notifications, 'arrow': true, 'badge': 3},
    {'title': '关于我们', 'icon': Icons.info, 'arrow': true},
    {'title': '帮助中心', 'icon': Icons.help, 'arrow': true},
  ];

  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF409EFF),
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: Center(
                    child: Text(
                      '管',
                      style: TextStyle(color: Colors.white, fontSize: 32.sp),
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('管理员', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5.h),
                      Text('超级管理员', style: TextStyle(fontSize: 14.sp, color: const Color(0xFF606266))),
                      SizedBox(height: 5.h),
                      Text('系统管理部', style: TextStyle(fontSize: 13.sp, color: const Color(0xFF909399))),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0xFFC0C4CC)),
              ],
            ),
          ),
          SizedBox(height: 10.w),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15.w),
            child: Column(
              children: _menuItems.map((item) {
                return GestureDetector(
                  onTap: () {
                    if (item['title'] == '修改密码') {
                      _showChangePasswordDialog();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.w),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: const Color(0xFFEBEEF5))),
                    ),
                    child: Row(
                      children: [
                        Icon(item['icon'], color: const Color(0xFF606266), size: 20.w),
                        SizedBox(width: 15.w),
                        Text(item['title'], style: TextStyle(fontSize: 15.sp)),
                        const Spacer(),
                        if (item['badge'] != null)
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF56C6C),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(child: Text('${item['badge']}', style: TextStyle(color: Colors.white, fontSize: 12.sp))),
                          ),
                        if (item['arrow'])
                          const Icon(Icons.chevron_right, color: Color(0xFFC0C4CC)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20.w),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  _handleLogout();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF56C6C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text('退出登录', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              ),
            ),
          ),
          SizedBox(height: 20.w),
          Center(
            child: Text('版本号 v1.0.0', style: TextStyle(fontSize: 13.sp, color: const Color(0xFF909399))),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.w,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('修改密码', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.w),
              TextField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '旧密码',
                  border: const OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15.w),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '新密码',
                  border: const OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15.w),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '确认新密码',
                  border: const OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 25.w),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: OutlinedButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('取消'),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () async {
                          String oldPassword = oldPasswordController.text;
                          String newPassword = newPasswordController.text;
                          String confirmPassword = confirmPasswordController.text;

                          if (newPassword != confirmPassword) {
                            Get.snackbar('提示', '两次密码输入不一致');
                            return;
                          }

                          try {
                            await _userController.changePassword(oldPassword, newPassword);
                            Get.snackbar('成功', '密码修改成功');
                            context.pop();
                          } catch (e) {
                            Get.snackbar('错误', e.toString());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF409EFF),
                        ),
                        child: Text('确认修改', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleLogout() {
    Get.defaultDialog(
      title: '提示',
      middleText: '确定要退出登录吗？',
      textCancel: '取消',
      textConfirm: '确定',
      onConfirm: () async {
        await _userController.logout();
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }
}
