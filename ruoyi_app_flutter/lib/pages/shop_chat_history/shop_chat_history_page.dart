import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShopChatHistoryPage extends StatelessWidget {
  const ShopChatHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聊天记录'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSearchBar(),
          const SizedBox(height: 16),
          _buildHistoryItem(context, '2024-01-15', '客服', '您好，有什么可以帮助您的？'),
          _buildHistoryItem(context, '2024-01-14', '客服', '感谢您的咨询'),
          _buildHistoryItem(context, '2024-01-13', '客服', '请问需要什么帮助？'),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: '搜索聊天记录',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, String date, String name, String message) {
    return GestureDetector(
      onTap: () {
        context.push('/shop_chat_history_details');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFEEEEEE)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: TextStyle(fontSize: 12.0, color: const Color(0xFF9E9E9E))),
            const SizedBox(height: 8),
            Text(name, style: TextStyle(fontSize: 14.0, color: Colors.black)),
            const SizedBox(height: 4),
            Text(message, style: TextStyle(fontSize: 14.0, color: const Color(0xFF757575))),
          ],
        ),
      ),
    );
  }
}