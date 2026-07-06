import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../chat_common_widget.dart';
import '../core/message_model.dart';
import '../util/chat_date_format.dart';
import 'circular_countdown.dart';
import 'text_with_clickable_links.dart';
import 'typing_indicator.dart';
import '../../../common/global_dialog.dart';
import '../../../utils/image_util.dart';

typedef MessageWidgetBuilder = Widget Function(BuildContext context, MessageModel message);
typedef OnBubbleClick = void Function(MessageModel message, BuildContext ancestor);

typedef HiSelectionArea = Widget Function({required Text child, required MessageModel message});

class DefaultMessageWidget extends StatelessWidget with ChatCommonWidget {
  final MessageModel message;

  final String? fontFamily;

  final double fontSize;

  final double avatarSize;

  final Color? textColor;

  final Color? backgroundColor;
  final MessageWidgetBuilder? messageWidget;

  final OnBubbleClick? onBubbleTap;

  final OnBubbleClick? onBubbleLongPress;

  final Widget? hiSelectionArea;

  final ValueChanged<Choice>? choose;
  final bool? isHistory;
  final String? searchKeyword;
  final bool? isHighlightSearchKeyword;

  DefaultMessageWidget(
      {required GlobalKey key,
        required this.message,
        this.fontFamily,
        this.fontSize = 13.0,
        this.textColor,
        this.backgroundColor,
        this.messageWidget,
        this.avatarSize = 32,
        this.onBubbleTap,
        this.onBubbleLongPress,
        this.choose,
        this.hiSelectionArea,
        this.isHistory,
        this.searchKeyword,
        this.isHighlightSearchKeyword,
      })
      : super(key: key);

  double get contentMargin => avatarSize + 8;

  String get senderInitials {
    List<String> chars = message.ownerName.split(" ");
    if (chars.length > 1) {
      return chars[0];
    } else {
      return message.ownerName.isNotEmpty ? message.ownerName[0] : '';
    }
  }

  Widget get _buildCircleAvatar {
    bool isHistory = this.isHistory ?? false;
    if (message.ownerType == OwnerType.sender && !isHistory) {
      return const SizedBox.shrink();
    }

    var child = message.senderRoleType == 'USER'
        ? _buildBase64Avatar(message.avatarBase64)
        : CircularCountdown(
      durationSeconds: 10,
      radius: (avatarSize - 2) / 2,
      strokeColor: const Color(0xFFF5F5F5),
      strokeWidth: 1,
      child: message.senderRoleType == 'AGENT'
          ? Icon(Icons.person, size: avatarSize / 2)
          : Icon(Icons.chat, size: avatarSize / 2),
      onControllerReady: (updateFn) {},
    );
    return child;
  }

  Widget _buildBase64Avatar(String? base64Icon) {
    const imageWidth = 24.0;
    const imageHeight = 24.0;
    Future<Uint8List?> imageFuture = (base64Icon == null || base64Icon.isEmpty)
        ? Future.value(null)
        : ImageUtil.instance().decodeBase64ToImage(base64Icon);
    return FutureBuilder<Uint8List?>(
      future: imageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            width: imageWidth,
            height: imageHeight,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
          );
        }

        ImageProvider imageProvider;
        if (snapshot.hasData) {
          Uint8List imageData = snapshot.data!;
          imageProvider = MemoryImage(imageData);
        } else {
          imageProvider = const AssetImage('');
        }

        return Container(
          width: imageWidth,
          height: imageHeight,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (messageWidget != null) {
      return messageWidget!(context, message);
    }
    bool isHistory = this.isHistory ?? false;
    Widget content = message.ownerType == OwnerType.receiver
        ? _buildReceiver(context)
        : (isHistory ? _buildReceiver(context) : _buildSender(context));
    return ValueListenableBuilder<Status>(
      valueListenable: message.status,
      builder: (BuildContext context, Status status, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (status == Status.typing)
              _buildReceiverSending(context)
            else if (status != Status.failed)
              child!,
            if (status == Status.failed) _buildFailedMessageContent(context),
          ],
        );
      },
      child: Column(
        children: [
          if (message.showCreatedTime) _buildCreatedTime(),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: content,
          ),
          if (message.choices.isNotEmpty &&
              message.ownerType == OwnerType.receiver)
            _buildChoicesContentText(TextAlign.left, context),
          if (isHistory == true) _buildBottomRightCreatedTime(),
        ],
      ),
    );
  }

  Widget _buildReceiverSending(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildCircleAvatar,
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
              padding:
              const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
              decoration: BoxDecoration(
                color: backgroundColor ?? const Color(0xFFF5F5F5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                      width: 26,
                      height: 24,
                      child: TypingIndicator(
                          flashingCircleDarkColor: const Color(0xFF757575),
                          flashingCircleBrightColor: const Color(0xFFE0E0E0)))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiver(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildCircleAvatar,
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
            padding:
            const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: _buildReceiverContentText(TextAlign.left, context),
          ),
        ),
      ],
    );
  }

  Widget _buildSender(
      BuildContext context, {
        Color? failedBackgroundColor,
        Color? borderColor,
        Color? failedTextColor,
      }) {
    var failedIconTextSpacing = failedTextColor != null ? 40 : 0;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(contentMargin, 0, 0, 0),
          child: failedTextColor != null
              ? GestureDetector(
            onTap: () {
              GlobalDialog.showDialogWithStyledMessage(
                message: '确定重新发送吗？',
                buttonTextList: [
                  '重新发送',
                  '取消'
                ],
                buttonMainStyleList: [true, false],
                onPressedList: [
                      () {
                    Navigator.of(context).pop();
                  },
                      () {
                    Navigator.of(context).pop();
                  }
                ],
                isVerticalButton: true,
              );
            },
            child: CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFFBDBDBD),
              child: Icon(Icons.refresh, size: 13),
            ),
          )
              : null,
        ),
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 36),
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  failedTextColor != null ? 8 : avatarSize, 0, 0, 0),
              padding:
              const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
              decoration: BoxDecoration(
                color: failedBackgroundColor ??
                    (backgroundColor ?? const Color(0xFFEEEEEE)),
                border:
                borderColor != null ? Border.all(color: borderColor) : null,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.zero,
                ),
              ),
              child:
              _buildSenderContentText(TextAlign.left, context, failedTextColor),
            ),
          ),
        ),
        failedTextColor != null ? SizedBox.fromSize() : _buildCircleAvatar,
      ],
    );
  }

  Widget _buildReceiverContentText(TextAlign align, BuildContext context) {
    Widget text = _buildPlainTextMessage(message.content, context);
    var messageType = (isHistory == true) ? false : true;
    Widget messageContent;
    List<Widget> choiceButtons = [];

    choiceButtons.clear();
    choiceButtons.add(_buildPlainTextMessage(message.content, context));

    messageContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: choiceButtons,
    );

    return InkWell(
        onTap: () =>
        onBubbleTap != null ? onBubbleTap!(message, context) : null,
        onLongPress: () => onBubbleLongPress != null
            ? onBubbleLongPress!(message, context)
            : null,
        child: messageType ? messageContent : text);
  }

  Widget _buildSenderContentText(
      TextAlign align, BuildContext context, Color? failedTextColor) {
    Color defaultTextColor = Colors.black;

    Widget failedText = Text(
      message.content,
      textAlign: align,
      style: TextStyle(
          fontSize: fontSize,
          color: failedTextColor ?? (textColor ?? defaultTextColor),
          fontFamily: fontFamily),
    );
    Widget normalText = TextWithClickableLinks(
      content: message.content,
      fontSize: 12.0,
      textColor: textColor ?? defaultTextColor,
      linkColor: Colors.black,
      lineHeight: 1.5,
      searchKeyword: searchKeyword,
      isHighlightSearchKeyword: isHighlightSearchKeyword,
    );

    return failedTextColor != null ? failedText : normalText;
  }

  Widget _buildChoicesContentText(TextAlign align, BuildContext context) {
    return Column(
      children: message.choices
          .map((choice) => _buildChoiceItem(choice, context))
          .toList(),
    );
  }

  Widget _buildChoiceItem(Choice choice, BuildContext context) {
    return InkWell(
      onTap: () => choose?.call(choice),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: choice.isSelected ? const Color(0xFFEEEEEE) : Colors.white,
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          choice.value,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildPlainTextMessage(String content, BuildContext context) {
    return TextWithClickableLinks(
      content: content,
      fontSize: 12.0,
      textColor: Colors.black,
      linkColor: Colors.black,
      lineHeight: 1.5,
      searchKeyword: searchKeyword,
      isHighlightSearchKeyword: isHighlightSearchKeyword,
    );
  }

  Widget _buildFailedMessageContent(BuildContext context) {
    return _buildSender(
      context,
      failedBackgroundColor: const Color(0xFFFEF0F0),
      borderColor: const Color(0xFFF56C6C),
      failedTextColor: const Color(0xFFF56C6C),
    );
  }

  Widget _buildCreatedTime() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Center(
        child: Text(
          ChatDateFormat.format(message.createdAt),
          style: TextStyle(
            fontSize: 11.sp,
            color: const Color(0xFF757575),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomRightCreatedTime() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      alignment: Alignment.bottomRight,
      child: Text(
        ChatDateFormat.format(message.createdAt),
        style: TextStyle(
          fontSize: 11.sp,
          color: const Color(0xFF757575),
        ),
      ),
    );
  }
}