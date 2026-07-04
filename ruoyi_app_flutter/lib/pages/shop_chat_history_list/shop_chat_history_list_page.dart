import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopChatHistoryListPage extends StatelessWidget {
  const ShopChatHistoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聊天记录列表'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildListItem(index);
        },
      ),
    );
  }

  Widget _buildListItem(int index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/shop_chat_history_details');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFEEEEEE)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.person, color: Color(0xFF9E9E9E)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('客服对话 $index', style: TextStyle(fontSize: 14.0, color: Colors.black)),
                  const SizedBox(height: 4),
                  Text('对话内容预览...', style: TextStyle(fontSize: 12.0, color: const Color(0xFF9E9E9E))),
                ],
              ),
            ),
            Text('1月${index + 1}日', style: TextStyle(fontSize: 12.0, color: const Color(0xFFBDBDBD))),
          ],
        ),
      ),
    );
  }
}