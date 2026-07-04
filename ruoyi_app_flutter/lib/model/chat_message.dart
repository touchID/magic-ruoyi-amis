class ChatMessage {
  final String id;
  final String conversationId;
  final String senderName;
  final String senderRoleType;
  final String text;
  final int timestamp;
  final MessageStatus status;

  ChatMessage({
    required this.id,
    required this.conversationId,
    required this.senderName,
    required this.senderRoleType,
    required this.text,
    required this.timestamp,
    this.status = MessageStatus.sent,
  });
}

enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
}

class ChatConversation {
  final String id;
  final String title;
  final List<ChatMessage> messages;
  final int lastMessageTime;
  final bool hasUnread;

  ChatConversation({
    required this.id,
    required this.title,
    required this.messages,
    required this.lastMessageTime,
    this.hasUnread = false,
  });
}
