import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../model/chat_message.dart';

class ShopChatPage extends StatefulWidget {
  const ShopChatPage({super.key});

  @override
  State<ShopChatPage> createState() => _ShopChatPageState();
}

class _ShopChatPageState extends State<ShopChatPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _conversationId = '';
  bool _isOperatorTyping = false;
  final ShopChatViewModel _viewModel = Get.put(ShopChatViewModel());

  @override
  void initState() {
    super.initState();
    _initChat();
  }

  void _initChat() {
    _viewModel.initChat(
      callback: (conversationId) {
        _conversationId = conversationId;
        _scrollToBottom();
      },
      operatorTypingCallback: (isTyping) {
        setState(() {
          _isOperatorTyping = isTyping;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildChatList(),
          _buildOperatorTypingHint(),
          _buildInputArea(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('在线客服'),
      centerTitle: true,
      actions: [
        _buildSearchButton(),
      ],
    );
  }

  Widget _buildSearchButton() {
    return IconButton(
      icon: Icon(Icons.search, size: 24),
      onPressed: () {
        context.push('/shop_chat_history');
      },
    );
  }

  Widget _buildChatList() {
    return Expanded(
      child: Obx(() => ListView.builder(
        controller: _scrollController,
        itemCount: _viewModel.messages.length,
        itemBuilder: (context, index) {
          ChatMessage message = _viewModel.messages[index];
          return _buildChatItem(message);
        },
      )),
    );
  }

  Widget _buildChatItem(ChatMessage message) {
    bool isOperator = message.senderRoleType == 'OPERATOR';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: isOperator ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (!isOperator) const SizedBox(width: 12),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isOperator ? const Color(0xFFF5F5F5) : const Color(0xFF212121),
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 14.0,
                  color: isOperator ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
          if (isOperator) const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _buildOperatorTypingHint() {
    if (_isOperatorTyping) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            const SizedBox(width: 48),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: Text(
                '客服正在输入...',
                style: TextStyle(fontSize: 14.0, color: const Color(0xFF757575)),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: '请输入消息',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.w),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: const Color(0xFF212121),
                borderRadius: BorderRadius.circular(24.w),
              ),
              child: Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String text = _inputController.text.trim();
    if (text.isEmpty) return;
    _viewModel.sendMessage(text, conversationId: _conversationId);
    _inputController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 1), () {
      _viewModel.receiveReply(text);
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

class ShopChatViewModel extends GetxController {
  final RxList<ChatMessage> _messages = RxList<ChatMessage>([]);

  List<ChatMessage> get messages => _messages.toList();

  void initChat({
    required Function(String) callback,
    required Function(bool) operatorTypingCallback,
  }) {
    _messages.value = [
      ChatMessage(
        id: '1',
        conversationId: 'test_conversation',
        senderName: '客服',
        senderRoleType: 'OPERATOR',
        text: '您好，请问有什么可以帮助您的？',
        timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        status: MessageStatus.sent,
      ),
      ChatMessage(
        id: '2',
        conversationId: 'test_conversation',
        senderName: '用户',
        senderRoleType: 'USER',
        text: '我想咨询一下产品相关的问题',
        timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 10,
        status: MessageStatus.read,
      ),
      ChatMessage(
        id: '3',
        conversationId: 'test_conversation',
        senderName: '客服',
        senderRoleType: 'OPERATOR',
        text: '好的，请问具体是关于哪款产品呢？我们有多种产品可供选择。',
        timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 20,
        status: MessageStatus.sent,
      ),
    ];
    callback('test_conversation');
  }

  void sendMessage(String text, {required String conversationId}) {
    _messages.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId: conversationId,
        senderName: '用户',
        senderRoleType: 'USER',
        text: text,
        timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        status: MessageStatus.sent,
      ),
    );
  }

  void receiveReply(String userText) {
    Map<String, String> replies = {
      '你好': '您好！很高兴为您服务。',
      '谢谢': '不客气，有问题随时联系我们。',
      '产品': '我们的产品包括多个系列，请问您想了解哪个？',
      '价格': '价格根据产品类型和配置有所不同，具体请咨询客服。',
      '帮助': '请问您需要哪方面的帮助？',
    };

    String reply = replies.entries.firstWhere(
      (entry) => userText.contains(entry.key),
      orElse: () => MapEntry('', '收到您的消息，我们会尽快处理。'),
    ).value;

    _messages.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId: 'test_conversation',
        senderName: '客服',
        senderRoleType: 'OPERATOR',
        text: reply,
        timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        status: MessageStatus.sent,
      ),
    );
  }
}