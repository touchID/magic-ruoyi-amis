import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _menuItems = [
    {'title': '用户管理', 'icon': Icons.person, 'color': Color(0xFF409EFF), 'count': 128},
    {'title': '角色管理', 'icon': Icons.group, 'color': Color(0xFF67C23A), 'count': 24},
    {'title': '菜单管理', 'icon': Icons.menu, 'color': Color(0xFFE6A23C), 'count': 156},
    {'title': '部门管理', 'icon': Icons.domain, 'color': Color(0xFF909399), 'count': 32},
    {'title': '岗位管理', 'icon': Icons.badge, 'color': Color(0xFFF56C6C), 'count': 48},
    {'title': '字典管理', 'icon': Icons.book, 'color': Color(0xFFB37FEB), 'count': 89},
    {'title': '系统日志', 'icon': Icons.file_copy, 'color': Color(0xFF3BA272), 'count': 1024},
    {'title': '在线用户', 'icon': Icons.online_prediction, 'color': Color(0xFF409EFF), 'count': 15},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF409EFF), Color(0xFF67C23A)],
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              padding: EdgeInsets.all(25.w),
              margin: EdgeInsets.only(bottom: 20.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '1,258',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              '总用户数',
                              style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '24',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              '在线用户',
                              style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '156',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              '菜单数',
                              style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              padding: EdgeInsets.zero,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 15.w,
              children: _menuItems.map((item) {
                return GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            // width: 60.w,
                            // height: 60.w,
                            decoration: BoxDecoration(
                              color: item['color'],
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(item['icon'], color: Colors.white, size: 28.w),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        item['title'],
                        style: TextStyle(fontSize: 12.sp, color: Color(0xFF606266)),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20.w),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('最近操作', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      Text('查看全部', style: TextStyle(fontSize: 13.sp, color: Color(0xFF409EFF))),
                    ],
                  ),
                  SizedBox(height: 15.w),
                  _buildOperationItem('admin', '修改用户信息', '2024-01-15 10:30'),
                  _buildOperationItem('admin', '新增角色', '2024-01-15 09:15'),
                  _buildOperationItem('admin', '删除部门', '2024-01-14 16:45'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOperationItem(String user, String action, String time) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEBEEF5))),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: Color(0xFF409EFF),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Center(child: Text(user[0], style: TextStyle(color: Colors.white))),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(action, style: TextStyle(fontSize: 14.sp, color: Color(0xFF303133))),
                SizedBox(height: 4.h),
                Text(time, style: TextStyle(fontSize: 12.sp, color: Color(0xFF909399))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
