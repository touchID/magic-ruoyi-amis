import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopChatHistoryDetailsPage extends StatelessWidget {
  const ShopChatHistoryDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聊天记录详情'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildChatBubble('您好，请问有什么可以帮助您的？', true),
          _buildChatBubble('我想咨询一下产品问题', false),
          _buildChatBubble('好的，请您详细描述一下问题', true),
          _buildChatBubble('产品使用过程中出现了错误提示', false),
          _buildChatBubble('收到，我帮您查询一下', true),
          _buildChatBubble('感谢您的耐心等待', true),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String message, bool isOperator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isOperator ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isOperator ? const Color(0xFFF5F5F5) : const Color(0xFF212121),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14.0,
                  color: isOperator ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}