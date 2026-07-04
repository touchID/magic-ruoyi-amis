import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'message_model.dart';

typedef MessageWidgetBuilder = Widget Function(BuildContext context, MessageModel message);

class ChatController implements IChatController {
  final List<MessageModel> initialMessageList;
  final ItemScrollController scrollController;
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final MessageWidgetBuilder? messageWidgetBuilder;
  final int timePellet;
  List<int> pelletShow = [];
  final isLoading = false.obs;
  final isStartEdit = false.obs;

  ChatController(
      {required this.initialMessageList, required this.scrollController, required this.timePellet, this.messageWidgetBuilder}) {
    for (var message in initialMessageList.reversed) {
      inflateMessage(message);
    }
  }

  StreamController<List<MessageModel>> messageStreamController = StreamController();

  void dispose() {
    messageStreamController.close();
    initialMessageList.clear();
    pelletShow.clear();
  }

  void widgetReady() {
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
    isLoading.listen((value) {});
  }

  @override
  void initMessage(List<MessageModel> reversedList) {
    if (messageStreamController.isClosed) return;

    initialMessageList.clear();
    for (var message in reversedList) {
      inflateMessage(message);
      initialMessageList.add(message);
    }
    messageStreamController.sink.add(initialMessageList);
  }

  @override
  void addMoreMessage(List<MessageModel> reversedList) {
    if (messageStreamController.isClosed) return;

    var isAdded = false;
    for (var message in reversedList) {
      if (!_isExists(message)) {
        inflateMessage(message);
        initialMessageList.add(message);
        isAdded = true;
      }
    }
    if (isAdded) {
      messageStreamController.sink.add(initialMessageList);
    }
  }

  @override
  void addMessage(MessageModel message) {
    if (messageStreamController.isClosed) return;

    if (_isExists(message)) {
      return;
    }
    if (message.ownerType == OwnerType.receiver) {
      hideTypingIndicator();
    }

    inflateMessage(message);
    initialMessageList.insert(0, message);
    messageStreamController.sink.add(initialMessageList);
    scrollToLastMessage();
  }

  @override
  void deleteMessage(MessageModel message) {
    if (messageStreamController.isClosed) return;

    final exists = initialMessageList.firstWhereOrNull(
            (it) => it.identifier == message.identifier
    );
    if (exists == null) {
      return;
    }

    initialMessageList.remove(exists);
    pelletShow.clear();
    for (var message in initialMessageList.reversed) {
      inflateMessage(message);
    }
    messageStreamController.sink.add(initialMessageList);
  }

  @override
  void updateMessageStatus(MessageModel message, Status status) {
    if (messageStreamController.isClosed) return;

    final exists = initialMessageList.firstWhereOrNull(
            (it) => it.identifier == message.identifier
    );
    if (exists != null) {
      exists.status.value = status;
    } else {
      message.status.value = status;
      addMessage(message);
    }
    messageStreamController.sink.add(initialMessageList);
  }

  @override
  void showTypingIndicator(MessageModel data, [String role = 'CHATBOT']) {
    if (messageStreamController.isClosed) return;

    if (data.senderRoleType != role) {
      return;
    }
    if (initialMessageList.firstWhereOrNull(
            (it) => it.status.value == Status.typing
    ) != null) {
      return;
    }
    data.status.value = Status.typing;
    addMessage(data);
  }

  @override
  void hideTypingIndicator() {
    if (messageStreamController.isClosed) return;

    initialMessageList.removeWhere((it) => it.status.value == Status.typing);
    messageStreamController.sink.add(initialMessageList);
  }

  bool _isExists(MessageModel message) {
    return initialMessageList.firstWhereOrNull(
            (it) => it.identifier == message.identifier
    ) != null;
  }

  void scrollToLastMessage() {
    if (scrollController.isAttached) {
      scrollController.jumpTo(index: 0);
    }
  }

  void inflateMessage(MessageModel message) {
    int pellet = (message.createdAt / (timePellet * 1000)).truncate();
    if (!pelletShow.contains(pellet)) {
      pelletShow.add(pellet);
      message.showCreatedTime = true;
    } else {
      message.showCreatedTime = false;
    }
  }
}

abstract class IChatController {
  void initMessage(List<MessageModel> reversedList);
  void addMoreMessage(List<MessageModel> reversedList);
  void addMessage(MessageModel message);
  void deleteMessage(MessageModel message);
  void updateMessageStatus(MessageModel message, Status status);
  void showTypingIndicator(MessageModel data);
  void hideTypingIndicator();
}
