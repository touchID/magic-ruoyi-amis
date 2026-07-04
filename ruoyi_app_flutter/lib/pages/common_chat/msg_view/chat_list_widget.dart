import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../core/chat_controller.dart';
import '../core/message_model.dart';
import 'message_widget.dart' hide MessageWidgetBuilder;

class ChatList extends StatefulWidget {
  final ChatController chatController;

  final EdgeInsetsGeometry? padding;

  final OnBubbleClick? onBubbleTap;

  final ValueChanged<Choice>? choose;

  final OnBubbleClick? onBubbleLongPress;
  final Widget? hiSelectionArea;
  final String? searchKeyword;
  final int? highlightIndex;

  const ChatList(
      {super.key,
        required this.chatController,
        this.padding,
        this.choose,
        this.onBubbleTap,
        this.onBubbleLongPress,
        this.hiSelectionArea,
        this.searchKeyword,
        this.highlightIndex,
      });

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  ChatController get chatController => widget.chatController;

  MessageWidgetBuilder? get messageWidgetBuilder => chatController.messageWidgetBuilder;

  ItemScrollController get scrollController => chatController.scrollController;
  ItemPositionsListener get itemPositionsListener => chatController.itemPositionsListener;

  Widget get _chatStreamBuilder {
    final screenHalfHeight = MediaQuery.of(context).size.height * 0.56;
    final isChatHistoryDetails = widget.searchKeyword?.isNotEmpty ?? false;
    return StreamBuilder<List<MessageModel>>(
      stream: chatController.messageStreamController.stream,
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.active
            ? ScrollablePositionedList.builder(
                reverse: true,
                padding: widget.padding?.resolve(TextDirection.ltr),
                itemScrollController: scrollController,
                itemCount: snapshot.data?.length ?? 0,
                itemPositionsListener: itemPositionsListener,
                itemBuilder: (BuildContext buildContext, int index) {
                  if (index < 0) {
                    return const SizedBox.shrink();
                  }
                  var model = snapshot.data![index];
                  return Column(
                    children: [
                      if (index == (snapshot.data!.length - 1)) const SizedBox(height: 16),
                      DefaultMessageWidget(
                        key: model.key,
                        message: model,
                        hiSelectionArea: widget.hiSelectionArea,
                        messageWidget: messageWidgetBuilder,
                        onBubbleTap: widget.onBubbleTap,
                        choose: widget.choose,
                        onBubbleLongPress: widget.onBubbleLongPress,
                        searchKeyword: widget.searchKeyword,
                        isHighlightSearchKeyword: index == widget.highlightIndex,
                      ),
                      if (index == 0) SizedBox(height: isChatHistoryDetails ? screenHalfHeight : 16),
                    ],
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    chatController.widgetReady();
    itemPositionsListener.itemPositions.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final positions = itemPositionsListener.itemPositions.value;
        //通知聊天列表更新
      });
    });
  }

  @override
  Widget build(context) {
    return Obx(() => !chatController.isLoading.value ? Align(
      alignment: Alignment.topCenter,
      child: _chatStreamBuilder,
    ) : const Center(
      child: CircularProgressIndicator(),
    ));
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }
}
