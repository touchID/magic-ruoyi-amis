import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shop_chat/shop_chat_page.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final List<Map<String, dynamic>> _messages = [
    {
      'id': 1,
      'title': '客户消息',
      'content': '有客户发来新消息，请及时回复',
      'time': '刚刚',
      'read': false,
      'icon': Icons.message,
      'color': Color(0xFF67C23A),
      'route': 'shop_chat',
    },
    {
      'id': 2,
      'title': '系统通知',
      'content': '您的账户已成功激活，可以正常使用系统功能。',
      'time': '今天 10:30',
      'read': false,
      'icon': Icons.info,
      'color': Color(0xFF409EFF),
    },
    {
      'id': 3,
      'title': '安全提醒',
      'content': '检测到您的账户在新设备上登录，请确认是否为本人操作。',
      'time': '今天 09:15',
      'read': false,
      'icon': Icons.security,
      'color': Color(0xFFF56C6C),
    },
    {
      'id': 4,
      'title': '系统更新',
      'content': '系统将于今晚22:00进行维护升级，预计持续2小时。',
      'time': '昨天 18:45',
      'read': true,
      'icon': Icons.update,
      'color': Color(0xFFE6A23C),
    },
    {
      'id': 5,
      'title': '任务提醒',
      'content': '您有3个待办任务即将到期，请及时处理。',
      'time': '昨天 14:20',
      'read': true,
      'icon': Icons.task,
      'color': Color(0xFF67C23A),
    },
    {
      'id': 6,
      'title': '权限变更',
      'content': '管理员已为您添加了「用户管理」权限。',
      'time': '前天 16:30',
      'read': true,
      'icon': Icons.person_add,
      'color': Color(0xFFB37FEB),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息'),
        actions: [
          IconButton(
            icon: Icon(Icons.mark_email_read),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(15.w),
        children: _messages.map((message) {
          return GestureDetector(
            onTap: () {
              setState(() {
                message['read'] = true;
              });
              if (message['route'] == 'shop_chat') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopChatPage()),
                );
              } else {
                _showMessageDetail(message);
              }
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10.w),
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFEBEEF5),
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                      color: message['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(message['icon'], color: message['color'], size: 22.w),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              message['title'],
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                            ),
                            if (!message['read'])
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF56C6C),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          message['content'],
                          style: TextStyle(fontSize: 13.sp, color: Color(0xFF606266)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          message['time'],
                          style: TextStyle(fontSize: 12.sp, color: Color(0xFF909399)),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Color(0xFFC0C4CC)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showMessageDetail(Map<String, dynamic> message) {
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
              Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: Color.alphaBlend(message['color'].withOpacity(0.1), Colors.transparent),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(message['icon'], color: message['color'], size: 24.w),
                  ),
                  SizedBox(width: 15.w),
                  Text(message['title'], style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20.w),
              Text(message['content'], style: TextStyle(fontSize: 15.sp, height: 1.6)),
              SizedBox(height: 20.w),
              Text(message['time'], style: TextStyle(fontSize: 13.sp, color: Color(0xFF909399))),
              SizedBox(height: 30.w),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF409EFF),
                  ),
                  child: Text('知道了', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}