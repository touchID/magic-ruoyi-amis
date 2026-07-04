import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum OwnerType { receiver, sender }

enum Status {
  typing,
  sending,
  sent,
  failed,
  none,
}

class Choice {
  final String optionId;
  final String identifier;
  final String title;
  final String value;
  final bool isSelected;
  final Rx<Color> bg;

  Choice(this.optionId, this.identifier, this.title, this.value, this.isSelected, {Rx<Color>? bg}) : bg = bg ?? Colors.white.obs;
}

class MessageModel {
  final int? id;
  final GlobalKey key;
  final String? avatarBase64;
  final String senderRoleType;
  final String senderDisplayName;
  final String identifier;
  final double timestamp;
  final String content;
  bool showCreatedTime = false;
  List<Choice> choices = List.empty();

  final ValueNotifier<Status> status;

  OwnerType get ownerType => senderRoleType == 'USER' ? OwnerType.sender : OwnerType.receiver;

  String get ownerName => senderDisplayName;

  int get createdAt => (timestamp * 1000.0).toInt();

  MessageModel({
    this.id,
    this.avatarBase64,
    required this.senderRoleType,
    required this.senderDisplayName,
    required this.identifier,
    required this.timestamp,
    required this.content,
  })  : key = GlobalKey(),
        status = ValueNotifier(Status.none);
}
