import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkbenchPage extends StatefulWidget {
  const WorkbenchPage({super.key});

  @override
  State<WorkbenchPage> createState() => _WorkbenchPageState();
}

class _WorkbenchPageState extends State<WorkbenchPage> {
  final List<Map<String, dynamic>> _tasks = [
    {'title': '完成用户管理模块测试', 'status': '进行中', 'priority': 'high', 'progress': 60},
    {'title': '修复登录页面Bug', 'status': '已完成', 'priority': 'high', 'progress': 100},
    {'title': '优化系统性能', 'status': '待开始', 'priority': 'medium', 'progress': 0},
    {'title': '编写API文档', 'status': '进行中', 'priority': 'low', 'progress': 30},
    {'title': '部署新版本到测试环境', 'status': '待开始', 'priority': 'high', 'progress': 0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('工作台'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border(left: BorderSide(color: Color(0xFF409EFF), width: 4.w)),
                    ),
                    padding: EdgeInsets.all(15.w),
                    child: Column(
                      children: [
                        Text('5', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.h),
                        Text('待办任务', style: TextStyle(fontSize: 12.sp, color: Color(0xFF909399))),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border(left: BorderSide(color: Color(0xFF67C23A), width: 4.w)),
                    ),
                    padding: EdgeInsets.all(15.w),
                    child: Column(
                      children: [
                        Text('2', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.h),
                        Text('进行中', style: TextStyle(fontSize: 12.sp, color: Color(0xFF909399))),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border(left: BorderSide(color: Color(0xFFE6A23C), width: 4.w)),
                    ),
                    padding: EdgeInsets.all(15.w),
                    child: Column(
                      children: [
                        Text('1', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.h),
                        Text('已完成', style: TextStyle(fontSize: 12.sp, color: Color(0xFF909399))),
                      ],
                    ),
                  ),
                ),
              ],
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
                      Text('任务列表', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      Icon(Icons.add, color: Color(0xFF409EFF)),
                    ],
                  ),
                  SizedBox(height: 15.w),
                  ..._tasks.map((task) => _buildTaskItem(task)),
                ],
              ),
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
                      Text('快捷操作', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 15.w),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    children: [
                      _buildQuickItem(Icons.add_circle, '新增用户', Color(0xFF409EFF)),
                      _buildQuickItem(Icons.delete, '删除用户', Color(0xFFF56C6C)),
                      _buildQuickItem(Icons.refresh, '刷新数据', Color(0xFF67C23A)),
                      _buildQuickItem(Icons.settings, '系统配置', Color(0xFF909399)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEBEEF5))),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: task['priority'] == 'high' ? Color(0xFFF56C6C) :
                         task['priority'] == 'medium' ? Color(0xFFE6A23C) : Color(0xFF67C23A),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(task['title'], style: TextStyle(fontSize: 14.sp)),
              ),
              Text(task['status'], style: TextStyle(fontSize: 12.sp, color: Color(0xFF909399))),
            ],
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: task['progress'] / 100,
            backgroundColor: Color(0xFFEBEEF5),
            color: Color(0xFF409EFF),
            borderRadius: BorderRadius.circular(3.r),
            minHeight: 6.h,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickItem(IconData icon, String title, Color color) {
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              // width: 50.w,
              // height: 50.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: color, size: 24.w),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(title, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}
